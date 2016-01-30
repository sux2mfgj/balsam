#pragma once

struct list_head
{
  struct list_head *next, *prev;
};

#define INIT_LIST_HEAD(ptr) do {\
    (ptr)->next = (ptr); (ptr)->prev = (ptr); \
} while(0)
