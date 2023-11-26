//
//  backtraceManager.h
//  ocdemo
//
//  Created by 吕凌浩 on 2023/11/26.
//

#ifndef backtraceManager_h
#define backtraceManager_h

#include <stdio.h>

typedef struct _backtrace_s {
    int frames;
    void *btrace[50];
    char *currentModuleName;
    char *currentMethodName;
} backtrace_s;

typedef struct _backtrace_s_link {
    struct _backtrace_s_link *next;
    backtrace_s *store;
} backtrace_s_link;

typedef struct _backtrace_m {
    backtrace_s_link *to_write_tail;
    backtrace_s_link *to_read_tail;
    backtrace_s_link *to_write;
    backtrace_s_link *to_read;
    size_t total_nodes;
    size_t has_writed;
    size_t has_read;
} backtrace_m;

backtrace_m *backtraceManagerAlloc(void);
// 返回一个待写的节点
backtrace_s_link *getStoreToWrite(backtrace_m *m);
// 放置已写到待读链表
void placeToReadLink(backtrace_m *m, backtrace_s_link *s);
// 返回一个待读取的节点
backtrace_s_link *getStoreToRead(backtrace_m *m);
// 放置一个读完的节点到待写链表
void placeToWriteLink(backtrace_m *m, backtrace_s_link *s);

void backtraceManagerDestory(backtrace_m **mm);

#endif /* backtraceManager_h */
