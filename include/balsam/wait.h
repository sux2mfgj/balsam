#pragma once

#include <balsam/list.h>
#include <asm-i386/spinlock.h>


struct __wait_queue_head
{
  spinlock_t lock;
  struct list_head task_list;
};

typedef struct __wait_queue_head wait_queue_head_t;

#define SPIN_LOCK_UNLOCKED (spinlock_t) {1}
#define spin_lock_init(x) do { *(x) = SPIN_LOCK_UNLOCKED;} while(0)

static inline void init_waitqueue_head(wait_queue_head_t *q)
{
  spin_lock_init(&q->lock);
  INIT_LIST_HEAD(&q->task_list);
}
