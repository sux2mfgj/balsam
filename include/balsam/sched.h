#pragma once 

#include <asm-i386/thread_info.h>

#ifndef __ASSEMBLY__

#include <stdint.h>

union thread_union {
    struct thread_info thread_info;
    uint32_t stack[THREAD_SIZE / sizeof(uint32_t)];
};

struct task_struct {
    // -1 unrunnable, 0 runnable, >0 stopped
    volatile uint32_t state; 
    
    struct thread_info *thread_info;

    //TODO add
};


#endif //__ASSEMBLY__
