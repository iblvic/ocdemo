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
#include "backtraceManager.h"
#include <sys/stat.h>
#include <sys/errno.h>

#define BUFFER_SIZE 1024

__unused static id (*xx_orig_objc_msgSend)(id, SEL, ...);
static void xx_hook_objc_msgSend(id self, SEL _cmd);
static void handleBacktrace(void);
static os_unfair_lock globalLock = OS_UNFAIR_LOCK_INIT;
static bool stop_handle = false;
static int MAP_SIZE = 4096;


typedef struct _msg_handler {
    backtrace_m *bt_m;
    int mapped_size;
    void *map_area;
    int fd;
    size_t writed_size;
} msg_handler;

static msg_handler msgHandler = {0};


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
    
    msgHandler.bt_m = backtraceManagerAlloc();
    char filePath[256] = {0};
    char fileName[50] = {0};
    sprintf(fileName, "/map_file.txt");
    documentPath(filePath, fileName);
    msgHandler.fd = open(filePath, O_RDWR | O_CREAT | O_TRUNC, (mode_t)0666);
    if (msgHandler.fd == - 1) {
        perror("open");
    }
    MAP_SIZE = getpagesize();
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
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{    
        handleBacktrace();
    });
}

void stopHandle(void) {
    stop_handle = true;
}

void printFile(int fd) {
    if (fd < 0) {
        return;
    }
    char buffer[BUFFER_SIZE];
    ssize_t bytesRead = 0;
    lseek(fd, 0, SEEK_SET);
    while ((bytesRead = read(fd, buffer, BUFFER_SIZE)) > 0) {
        if (write(STDOUT_FILENO, buffer, bytesRead) != bytesRead) {
            perror("write");
        }
    }
}
static void copyStrToMapArea(const char *str) {
    while (*str != '\0') {
        if (msgHandler.mapped_size <= 0) {
            if (msgHandler.map_area) {
                if (munmap(msgHandler.map_area, MAP_SIZE) == -1) {
                    perror("munmap");
                    return;
                }
            }
            size_t total_size = msgHandler.writed_size + MAP_SIZE;
            // 将文件大小调整为数据长度
            if (lseek(msgHandler.fd, total_size-1, SEEK_SET) == -1) {
                perror("Error calling lseek() to 'stretch' the file");
                return;
            } else {
                printf("file size:%ld Byte\n", total_size);
            }
            // 写入一个空字节，确保文件大小达到指定大小
            if (write(msgHandler.fd, "", 1) == -1) {
                perror("Error writing last byte of the file\n");
                return;;
            }
            msgHandler.map_area = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED|MAP_FILE, msgHandler.fd, msgHandler.writed_size);
            if (msgHandler.map_area == MAP_FAILED) {
                perror("mmap");
                printf("errorn:%d", errno);
                return;;
            }
            msgHandler.mapped_size = MAP_SIZE;
        }
        char *to_write = msgHandler.map_area + (MAP_SIZE - msgHandler.mapped_size);
        *to_write = *str;
        str++;
        msgHandler.mapped_size--;
        msgHandler.writed_size++;
    }
}
static void handleBacktrace() {
    if (stop_handle || msgHandler.fd < 0 || msgHandler.map_area == MAP_FAILED) return;
    while (true) {
        backtrace_s_link *node = getStoreToRead(msgHandler.bt_m);
        if (node != NULL) {
            char **strs = backtrace_symbols(node->store->btrace, node->store->frames);
            placeToWriteLink(msgHandler.bt_m, node);
            if (node->store->currentModuleName) {
                copyStrToMapArea(node->store->currentModuleName);
                copyStrToMapArea(":");
            }
            if (node->store->currentMethodName) {
                copyStrToMapArea(node->store->currentMethodName);
                copyStrToMapArea("\n");
            }
            for (int i = 0; i < node->store->frames; ++i) {
                copyStrToMapArea(strs[i]);
                copyStrToMapArea("\n");
            }
            copyStrToMapArea("|\n");
        } else {
            printf("no node to handle\n");
            struct stat file_stat;
            if (fstat(msgHandler.fd, &file_stat) == -1) {
                perror("Error getting file size\n");
                goto done;
            }
            printf("map file size:%lld, map offset: %ld, page size:%d, has_writed:%ld, has_read:%ld, left_to_read:%ld, total_nodes:%ld\n", file_stat.st_size, msgHandler.writed_size, getpagesize(), msgHandler.bt_m->has_writed, msgHandler.bt_m->has_read, msgHandler.bt_m->has_writed - msgHandler.bt_m->has_read, msgHandler.bt_m->total_nodes);
            sleep(1);
        }
        if (stop_handle) {
            goto done;
        }
    }
done:
    if (msgHandler.fd != -1) {
        close(msgHandler.fd);
    }
    if (msgHandler.map_area != MAP_FAILED && munmap(msgHandler.map_area, MAP_SIZE) == -1) {
        perror("munmap");
    }
    backtraceManagerDestory(&msgHandler.bt_m);
}

void printFileContent(void) {

    char filePath[256] = {0};
    char fileName[50] = {0};
    sprintf(fileName, "/map_file.txt");
    documentPath(filePath, fileName);
    int fd = open(filePath, O_RDWR, (mode_t)0600);
    if (fd == - 1) {
        perror("open");
    }
    printf("print map_file.txt\n");
    printFile(fd);
    close(fd);
}

void xx_before_objc_msgSend(id self, SEL _cmd) {
    if(stop_handle || strstr(sel_getName(_cmd), "dealloc") || strstr(sel_getName(_cmd), "_xref_dispose")) return;
    Class _cls = object_getClass(self);
    const char *imageName = class_getImageName(_cls);
    char *currentModuleName = basename((char *)imageName);
//    if(imageName && strstr(imageName, "ocdemo") == NULL) {
    os_unfair_lock_lock(&globalLock);
    backtrace_s_link *node = getStoreToWrite(msgHandler.bt_m);
    node->store->currentModuleName = (char *)calloc(strlen(currentModuleName)+1, sizeof(char));
    sprintf(node->store->currentModuleName, "%s", currentModuleName);
    char methodName[256] = {0};
    int len = sprintf(methodName, "%s[%s %s]", class_isMetaClass(_cls) ? "+" : "-", class_getName(_cls), sel_getName(_cmd));
    node->store->currentMethodName = (char *)calloc(len+1, sizeof(char));
    strcpy(node->store->currentMethodName, methodName);
    node->store->frames = backtrace(node->store->btrace, node->store->frames);
    placeToReadLink(msgHandler.bt_m, node);
    os_unfair_lock_unlock(&globalLock);
//    }
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

