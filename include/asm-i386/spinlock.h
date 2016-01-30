#pragma once

typedef struct
{
  volatile uint32_t slock;
  //CONFIG_PREEMPT
  uint32_t break_lock;
} spinlock_t;
