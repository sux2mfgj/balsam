#pragma once

#include <stdint.h>

#include <balsam/list.h>
#include <balsam/types.h>

#include <asm-i386/atomic.h>

typedef uint32_t page_flags_t;

struct page {
    page_flags_t flags;

    atomic_t _count;
    atomic_t _mapcount;

    uint32_t private;

    struct address_space *mapping;

    pgoff_t index;
    struct list_head lru;

    void *virtual;  // TODO inspect ??
};

extern struct page *mem_map;

extern void free_area_init(uint32_t *zones_size);
extern void free_area_init_node(int nid, struct pglist_data *pgdat,
                                uint32_t *zones_size, uint32_t node_start_pfn,
                                uint32_t *zholes_size);
