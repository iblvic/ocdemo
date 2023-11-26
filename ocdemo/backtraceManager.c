//
//  backtraceManager.c
//  ocdemo
//
//  Created by 吕凌浩 on 2023/11/26.
//

#include "backtraceManager.h"
#include <malloc/_malloc.h>
#include <string.h>
#include <os/lock.h>

// 脱链
#define takeoff(p) \
p->next = NULL; \

#define connect(p, s) \
p->next = s; \
s->next = NULL;

static os_unfair_lock slock = OS_UNFAIR_LOCK_INIT;

backtrace_m *backtraceManagerAlloc(void) {
    backtrace_m *p = (backtrace_m *)calloc(1, sizeof(backtrace_m));
    p->to_write_tail = NULL;
    p->to_read_tail = NULL;
    p->to_read = NULL;
    p->to_write = NULL;
    p->has_read = 0;
    p->has_writed = 0;
    p->total_nodes = 0;
    return p;
}
// 返回一个待写的节点
backtrace_s_link *getStoreToWrite(backtrace_m *m) {
    os_unfair_lock_lock(&slock);
    backtrace_s_link *ret = NULL;
    if (m->to_write == NULL) {
        backtrace_s_link *p = (backtrace_s_link *)calloc(1, sizeof(backtrace_s_link));
        p->next = NULL;
        p->store = (backtrace_s *)calloc(1, sizeof(backtrace_s));
        p->store->frames = 50;
        memset(p->store->btrace, 0, 50);
        m->to_write = p;
        m->to_write_tail = p;
        ret = p;
        m->total_nodes++;
        printf("alloc node, totoal nodes:%ld\n", m->total_nodes);
    } else {
        ret = m->to_write;
    }
    os_unfair_lock_unlock(&slock);
    return ret;
}
// 放置到待读链表
void placeToReadLink(backtrace_m *m, backtrace_s_link *s) {
    os_unfair_lock_lock(&slock);
    if (m->to_write_tail == s) {
        m->to_write_tail = NULL;
    }
    m->to_write = m->to_write->next;
    takeoff(s)
    if (m->to_read_tail) {
        connect(m->to_read_tail, s);
        m->to_read_tail = s;
    } else {
        m->to_read_tail = s;
        m->to_read = s;
    }
    m->has_writed++;
    os_unfair_lock_unlock(&slock);
}

// 返回一个待读取的节点
backtrace_s_link *getStoreToRead(backtrace_m *m) {
    os_unfair_lock_lock(&slock);
    backtrace_s_link *ret = m->to_read;
    os_unfair_lock_unlock(&slock);
    return ret;
}
// 放置到待写链表
void placeToWriteLink(backtrace_m *m, backtrace_s_link *s) {
    os_unfair_lock_lock(&slock);
    if (m->to_read_tail == s) {
        m->to_read_tail = NULL;
    }
    m->to_read = m->to_read->next;
    takeoff(s);
    if (m->to_write_tail) {
        connect(m->to_write_tail, s)
        m->to_write_tail = s;
    } else {
        m->to_write = s;
        m->to_write_tail = s;
    }
    m->has_read++;
    os_unfair_lock_unlock(&slock);
}

void destroyNode(backtrace_s_link *l) {
    if (!l) return;
    if (l->store) {
        if (l->store->currentModuleName) {
            free(l->store->currentModuleName);
        }
        if (l->store->currentMethodName) {
            free(l->store->currentMethodName);
        }
        free(l->store);
    }
    free(l);
}
void backtraceManagerDestory(backtrace_m **mm) {
    backtrace_m *m = *mm;
    os_unfair_lock_lock(&slock);
    if (!m) return;
    backtrace_s_link *p = m->to_read;
    while (p) {
        backtrace_s_link *tmp = p->next;
        destroyNode(p);
        p = tmp;
    }
    p = m->to_write;
    while (p) {
        backtrace_s_link *tmp = p->next;
        destroyNode(p);
        p = tmp;
    }
    free(m);
    *mm = NULL;
    os_unfair_lock_unlock(&slock);
}
