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

  /*atomic_t usage;
  uint32_t flags;
  uint32_t ptrace;

  int lock_depth;

  int prio, static_prio;
  struct list_head run_list;
  prio_array_t *array;

  uint16_t ioprio;
  uint32_t sleep_avg;
  uint64_t timestamp, last_ran;
  uint64_t sched_time;
  int activated;

  uint32_t policy;
  cpumask_t cpus_allowed;
  uint32_t time_slice, first_time_slice;
  */

    //TODO add
};


#endif //__ASSEMBLY__
