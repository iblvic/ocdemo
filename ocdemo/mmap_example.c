//
//  mmap_example.c
//  ocdemo
//
//  Created by haosimac on 2023/11/25.
//

#include "mmap_example.h"

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <string.h>
#include <unistd.h>
#include "hookmsg.h"

int mmap_test(void) {
    // 创建一个文件
    char filePath[256] = {0};
    char fileName[50] = {0};
    sprintf(fileName, "/map_file_%d.txt", 1);
    documentPath(filePath, fileName);
    int fd = open(filePath, O_RDWR | O_CREAT | O_TRUNC, (mode_t)0600);
    if (fd == -1) {
        perror("open");
        exit(EXIT_FAILURE);
    }

    // 将文件扩展到所需大小
    off_t file_size = 4096;
    if (lseek(fd, file_size - 1, SEEK_SET) == -1) {
        perror("lseek");
        exit(EXIT_FAILURE);
    }
    if (write(fd, "", 1) == -1) {
        perror("write");
        exit(EXIT_FAILURE);
    }

    // 映射文件到内存
    void *mapped_area = mmap(NULL, file_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    if (mapped_area == MAP_FAILED) {
        perror("mmap");
        exit(EXIT_FAILURE);
    }

    // 在映射区域写入数据
    const char *data = "Hello, mmap with file!\n";
    strncpy(mapped_area, data, strlen(data));

    // 打印映射区域的内容
    printf("Content in mapped area: %s\n", (char *)mapped_area);

    // 解除映射
    if (munmap(mapped_area, file_size) == -1) {
        perror("munmap");
        exit(EXIT_FAILURE);
    }
#define BUFFER_SIZE 1024
    char buffer[BUFFER_SIZE];
    ssize_t bytesRead;
    lseek(fd, 0, SEEK_SET);
    while ((bytesRead = read(fd, buffer, BUFFER_SIZE)) > 0) {
        if (write(STDOUT_FILENO, buffer, bytesRead) != bytesRead) {
            perror("write");
            exit(EXIT_FAILURE);
        }
    }
    // 关闭文件
    close(fd);

    return 0;
}
