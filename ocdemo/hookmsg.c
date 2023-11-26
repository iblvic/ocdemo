//
//  hookmsg.c
//  MedicalForumDylib
//
//  Created by haosimac on 2023/9/27.
//

#include <pthread.h>
#include <stdlib.h>
#include <sys/time.h>
#include <objc/runtime.h>
#include <dispatch/dispatch.h>
#include "fishhook.h"
#include <execinfo.h>
#include <stdio.h>
#include <libgen.h>
#include "hookmsg.h"
#include <sys/mman.h>
#include <os/lock.h>

#define MAP_SIZE 4096

__unused static id (*xx_orig_objc_msgSend)(id, SEL, ...);
static void xx_hook_objc_msgSend(id self, SEL _cmd);
static void handleBacktrace(int idx);
static int* fds = NULL;
static int *mapped_sizes = NULL;
static void **map_areas = NULL;
static size_t *writed_sizes = NULL;
static int threadNum = 1;
static void **backtrace_pointers = NULL;
static void **current_backtrace_p = NULL;
static void **handle_current_backtrace_p = NULL;
static int *backtrace_sizes = NULL;
static int *handle_backtrace_sizes = NULL;
static int *backtrace_left_sizes = NULL;
static size_t method_count = 0;
static os_unfair_lock globalLock = OS_UNFAIR_LOCK_INIT;
//static dispatch_semaphore_t *handler_semaphores = NULL;
static bool stop_handle = false;

void xx_dtp_hook_begin(void) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rebind_symbols((struct rebinding[1]){"objc_msgSend", (void *)xx_hook_objc_msgSend, (void **)&xx_orig_objc_msgSend},1);
    });
}

//void dtp_hook_end(void) {
//    rebind_symbols((struct rebinding[1]){"objc_msgSend", (void *)xx_orig_objc_msgSend, NULL},1);
//}

__attribute__((constructor)) static void xx_hook_entry(void) {
    backtrace_pointers = calloc(threadNum, sizeof(void*));
    current_backtrace_p = calloc(threadNum, sizeof(void*));
    handle_current_backtrace_p = calloc(threadNum, sizeof(void*));
    backtrace_sizes = calloc(threadNum, sizeof(int));
    handle_backtrace_sizes = calloc(threadNum, sizeof(int));
    backtrace_left_sizes = calloc(threadNum, sizeof(int));
    fds = calloc(threadNum, sizeof(int));
    mapped_sizes = calloc(threadNum, sizeof(int));
    map_areas = calloc(threadNum, sizeof(void*));
    writed_sizes = calloc(threadNum, sizeof(size_t));
//    handler_semaphores = calloc(threadNum, sizeof(dispatch_semaphore_t));
    for (int i = 0; i < threadNum; i++) {
        backtrace_pointers[i] = NULL;
        current_backtrace_p[i] = NULL;
        handle_current_backtrace_p[i] = NULL;
        backtrace_sizes[i] = 0;
        handle_backtrace_sizes[i] = 0;
        backtrace_left_sizes[i] = 0;
        fds[i] = -1;
        mapped_sizes[i] = 0;
        map_areas[i] = NULL;
        writed_sizes[i] = 0;
//        handler_semaphores[i] = dispatch_semaphore_create(0);
        
        char filePath[256] = {0};
        char fileName[50] = {0};
        sprintf(fileName, "/map_file_%d.txt", i+1);
        documentPath(filePath, fileName);
        fds[i] = open(filePath, O_RDWR | O_CREAT | O_TRUNC, (mode_t)0600);
        if (fds[i] == - 1) {
            perror("open");
        }
    }
    xx_dtp_hook_begin();
}


// arm64 hook objc_msgSend
// volatile为可选关键字，表示不需要gcc对下面的汇编代码做任何优化

// 函数调用，value传入函数地址
// 将参数value(地址)传递给x12寄存器
// blr开始执行
#define call(b, value) \
    __asm volatile ("stp x8, x9, [sp, #-16]!\n"); \
    __asm volatile ("mov x12, %0\n" :: "r"(value)); \
    __asm volatile ("ldp x8, x9, [sp], #16\n"); \
    __asm volatile (#b " x12\n");


#define save() \
    __asm volatile ( \
        "sub sp, sp, #0xE0\n" \
        "stp x29, x30, [sp, #0xD0]\n" \
        "add x29, sp, #0xD0\n" \
        "stp q6, q7, [sp, #0xB0]\n" \
        "stp q4, q5, [sp, #0x90]\n" \
        "stp q2, q3, [sp, #0x70]\n" \
        "stp q0, q1, [sp, #0x50]\n" \
        "stp x8, x9, [sp, #0x40]\n" \
        "stp x6, x7, [sp, #0x30]\n" \
        "stp x4, x5, [sp, #0x20]\n" \
        "stp x2, x3, [sp, #0x10]\n" \
        "stp x0, x1, [sp]\n");

//还原寄存器参数信息
//依次将寄存器数据出栈
#define load() \
    __asm volatile ( \
        "ldp x29, x30, [sp, #0xD0]\n" \
        "ldp q6, q7, [sp, #0xB0]\n" \
        "ldp q4, q5, [sp, #0x90]\n" \
        "ldp q2, q3, [sp, #0x70]\n" \
        "ldp q0, q1, [sp, #0x50]\n" \
        "ldp x8, x9, [sp, #0x40]\n" \
        "ldp x6, x7, [sp, #0x30]\n" \
        "ldp x4, x5, [sp, #0x20]\n" \
        "ldp x2, x3, [sp, #0x10]\n" \
        "ldp x0, x1, [sp]\n" \
        "add sp, sp, #0xE0\n");


#define link(b, value) \
    __asm volatile ("stp x8, lr, [sp, #-16]!\n"); \
    __asm volatile ("sub sp, sp, #16\n"); \
    call(b, value); \
    __asm volatile ("add sp, sp, #16\n"); \
    __asm volatile ("ldp x8, lr, [sp], #16\n");

//程序执行完成,返回将继续执行lr中的函数
#define ret() __asm volatile ("ret\n");
void startHandle(void) {
//    for (int i = 0; i < threadNum; i++) {
//        dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
//            handleBacktrace(i);
//        });
//    }
}
void stopHandle(void) {
    stop_handle = true;
    for (int i = 0; i < threadNum; i++) {
//        dispatch_semaphore_signal(handler_semaphores[i]);
    }
}
static void handleBacktrace(int idx) {
    if (stop_handle || fds[idx] < 0 || map_areas[idx] == MAP_FAILED) return;
    while (true) {
//        dispatch_semaphore_wait(handler_semaphores[idx], DISPATCH_TIME_FOREVER);
        void **current_btp = handle_current_backtrace_p[idx];
        if (current_btp == NULL) {
            current_btp = backtrace_pointers[idx];
            handle_current_backtrace_p[idx] = current_btp;
        }
        while ((uintptr_t)current_btp < (uintptr_t)(backtrace_pointers[idx] + backtrace_sizes[idx])) {
            int frames = 0;
            while (*current_btp != NULL) {
                frames++;
                current_btp++;
            }
            char **strs = backtrace_symbols(current_btp, frames);
            for (int i = 0; i < frames; ++i) {
                size_t left_size = mapped_sizes[idx];
                if (left_size < 256) {
                    if (map_areas[idx]) {
                        if (munmap(map_areas[idx], MAP_SIZE) == -1) {
                            perror("munmap");
                        }
                    }
                    map_areas[idx] = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fds[idx], writed_sizes[idx]);
                    if (map_areas[idx] == MAP_FAILED) {
                        perror("mmap");
                        return;
                    }
                    size_t total_size = writed_sizes[idx] + MAP_SIZE;
                    // 将文件大小调整为数据长度
                    if (lseek(fds[idx], total_size - 1, SEEK_SET) == -1) {
                        close(fds[idx]);
                        perror("Error calling lseek() to 'stretch' the file");
                        return;
                    }
                    // 写入一个空字节，确保文件大小达到指定大小
                    if (write(fds[idx], "", 1) == -1) {
                        close(fds[idx]);
                        perror("Error writing last byte of the file");
                        return;
                    }
                    mapped_sizes[idx] = MAP_SIZE;
                }
                char *map_p = map_areas[idx];
                char *to_write = map_p + (MAP_SIZE - mapped_sizes[idx]);
                int size = sprintf(to_write, "%s\n", strs[i]);
                writed_sizes[idx] += size;
                mapped_sizes[idx] -= size;
            }
            current_btp++;
            handle_current_backtrace_p[idx] = current_btp;
        }
//        printf("handle idx = %d\n", idx);
        if (stop_handle) {
            return;
        }
        sleep(1);
    }
}

void printFileContent(void) {
#define BUFFER_SIZE 1024
    for (int i = 0; i < threadNum; i++) {
        printf("print map_file_%d.txt\n", i+1);
        char buffer[BUFFER_SIZE];
        ssize_t bytesRead = 0;
        lseek(fds[i], 0, SEEK_SET);
        while ((bytesRead = read(fds[i], buffer, BUFFER_SIZE)) > 0) {
            if (write(STDOUT_FILENO, buffer, bytesRead) != bytesRead) {
                perror("write");
            }
        }
    }
}

void xx_before_objc_msgSend(id self, SEL _cmd) {
    if(stop_handle || strstr(sel_getName(_cmd), "dealloc") || strstr(sel_getName(_cmd), "_xref_dispose")) return;
    Class _cls = object_getClass(self);
    const char *imageName = class_getImageName(_cls);
    //char *moduleName = basename((char *)imageName);
    if(imageName && strstr(imageName, "ocdemo") == NULL) {
        os_unfair_lock_lock(&globalLock);
        int idx = method_count % threadNum;
//        void **current_btp = current_backtrace_p[idx];
//        if (current_btp == NULL) {
//            void *btp = calloc(4096, sizeof(void *));
//            if (btp) {
//                current_btp = btp;
//                backtrace_pointers[idx] = btp;
//                current_backtrace_p[idx] = btp;
//                backtrace_sizes[idx] = 4096;
//                backtrace_left_sizes[idx] = 4096;
//            }
//        }
//        int left_size = backtrace_left_sizes[idx];
//        if (left_size < 128) {
//            void **p = backtrace_pointers[idx];
//            p = realloc(p, backtrace_sizes[idx]+4096);
//            if(p != backtrace_pointers[idx]) {
//                current_backtrace_p[idx] = p + ((uintptr_t)current_btp - (uintptr_t)backtrace_pointers[idx]);
//                current_btp = current_backtrace_p[idx];
//            }
//            if (p) {
//                backtrace_pointers[idx] = p;
//                backtrace_sizes[idx] += 4096;
//                left_size += 4096;
//                backtrace_left_sizes[idx] = left_size;
//            } else {
//                printf("error");
//            }
//        }
        void **current_btp = calloc(128, sizeof(void*));
        int frames = backtrace(current_btp, 128);
        free(current_btp);
//        frames++;
//        *(current_btp + frames) = NULL;
//        current_backtrace_p[idx] = current_btp + frames;
//        backtrace_left_sizes[idx] = left_size - frames;
        method_count++;
//        dispatch_semaphore_signal(handler_semaphores[idx]);
        os_unfair_lock_unlock(&globalLock);
        
//        char **strs = backtrace_symbols(callstack, frames);
//        for (int i = 0; i < frames; ++i) {
//            size_t len = strlen(strs[i]) + 1; // 1为\n
//            size_t left_size = mapped_size - len;
//            if (left_size < 0) {
//                map_area = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, writed_size);
//                if (map_area == MAP_FAILED) {
//                    perror("mmap");
//                }
//                mapped_size = MAP_SIZE;
//            }
//            vsprintf(map_area, "%s\n", strs[i]);
////            printf("%s\n", strs[i]);
//            const char *left = strstr(strs[i], "[");
//            if(left) {
//                left++;
//                const char *right = strstr(left, " ");
//                if(right) {
//                    size_t len = (uintptr_t)right - (uintptr_t)left;
//                    char *className = malloc(len+1);
//                    className[len] = '\0';
//                    strncpy(className, left, len);
//                    Class c = objc_getClass(className);
//                    if(c) {
//                        const char *imagePath = class_getImageName(c);
//                        if(imagePath && strstr(imagePath, "ocdemo")) {
//                            printf("[mtrace]: %s -> [%s %s]\n", moduleName, class_getName(_cls), sel_getName(_cmd));
//                            break;
//                        }
//                    }
//                }
//            }
//        }
//        free(strs);
//        printf("[mtrace]: [%s %s]\n", class_getName(_cls), sel_getName(_cmd));
    }
}

/**
 *__naked__修饰的函数告诉编译器在函数调用的时候不使用栈保存参数信息，
 *同时函数返回地址会被保存到LR寄存器上。
 *由于msgSend本身就是用这个修饰符的，
 *因此在记录函数调用的出入栈操作中，
 *必须保证能够保存以及还原寄存器数据。
 *msgSend利用x0 - x9的寄存器存储参数信息，
 *可以手动使用sp寄存器来存储和还原这些参数信息
 */
//msgSend必须使用汇编实现
__attribute__((__naked__))
static void xx_hook_objc_msgSend(id self, SEL _cmd) {
    //before之前保存objc_msgSend的参数
    save()
    
    // 执行xx_before_objc_msgSend   blr 除了从指定寄存器读取新的 PC 值外效果和 bl 一...
    call(blr, &xx_before_objc_msgSend)
    
    load()
    
    call(br, xx_orig_objc_msgSend)
    
    ret()
}

