#pragma once

#include <stdint.h>

#include <balsam/list.h>
#include <balsam/types.h>

typedef uint32_t page_flags_t;

struct page
{
  page_flags_t flags;

  atomic_t _count;
  atomic_t _mapcount;

  uint32_t private;

  struct address_space *mapping;

  pgoff_t index;
  struct list_head lru;

  void *virtual; //TODO inspect ??
};
