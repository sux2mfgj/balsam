#pragma once

#include <balsam/list.h>
#include <asm-i386/spinlock.h>


struct __wait_queue_head
{
  spinlock_t lock;
  struct list_head task_list;
};

typedef struct __wait_queue_head wait_queue_head_t;
