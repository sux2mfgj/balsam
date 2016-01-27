#pragma once

#include <balsam/wait.h>
#include <balsam/list.h>
#include <balsam/threads.h>
#include <asm-i386/atomic.h>

#define ZONE_DMA       0
#define ZONE_NORMAL    1
#define ZONE_HIGHMEM   2

#define MAX_NR_ZONES   3

#define DEF_PRIORITY 12

extern struct page *mem_map;

extern struct pglist_data contig_page_data;
extern struct pglist_data *pgdat_list;

#define NODE_DATA(nid) (&contig_page_data)

#define MAX_ORDER 11
//#define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER

#define GFP_ZONEMASK 0x03
#define GFP_ZONETYPES ((GFP_ZONEMASK + 1) / 2 + 1) //TODO

struct per_cpu_pages
{
  int count;
  int low;
  int high;
  int batch;
  struct list_head list;
};

struct per_cpu_pageset
{
  struct per_cpu_pages pcp[2];
}; //CONFIG_SMP

struct free_area
{
  struct list_head free_list;
  uint32_t nr_free;
};

struct zone {
  uint32_t free_pages;
  uint32_t pages_min, pages_low, pages_high;

  uint32_t lowmem_reserve[MAX_NR_ZONES];

  struct per_cpu_pageset pageset[NR_CPUS];

  spinlock_t lock;
  struct free_area free_area[MAX_ORDER];

  //CONFIG_SMP ZONE_PADDING(_pad1_)

  spinlock_t lru_lock;
  struct list_head active_list;
  struct list_head inactive_list;
  uint32_t nr_scan_active;
  uint32_t nr_scan_inactive;

  uint32_t nr_active;
  uint32_t nr_inactive;

  uint32_t pages_scanned;
  int all_unreclaimable;

  int reclaim_pages;
  atomic_t reclaim_in_progress;

  int temp_priority;
  int prev_priority;

  //CONFIG_SMP ZONE_PADDING(_pad2_)

  wait_queue_head_t * wait_table;
  uint32_t wait_table_size;
  uint32_t wait_table_bits;

  struct pglist_data *zone_pgdat;
  struct page *zone_mem_map;

  uint32_t zone_start_pfn;
  uint32_t spanned_pages;
  uint32_t present_pages;

  char *name;
}; //CONFIG_SMP

struct zonelist {
  struct zone *zones[MAX_NR_ZONES + 1];
};

typedef struct pglist_data
{
  struct zone node_zones[MAX_NR_ZONES];   //TODO
  struct zonelist node_zonelists[GFP_ZONETYPES];//TODO

  int nr_nozes;
  struct page *node_mem_map;
  struct bootmem_data *bdata;
  uint32_t node_start_pfn;
  uint32_t node_present_pages;
  uint32_t node_spanned_pages;

  int node_id;
  struct pglist_data *pgdat_next;
  wait_queue_head_t kswapd_wait;
  struct task_struct *kswapd;
  int kswapd_max_order;
} pg_data_t;

/*
#define alloc_bootmem_low_pages((x) \
  __alloc_bootmem((x), PAGE_SIZE, 0)

#define for_each_pgdat(pgdat) \
  for(pgdat = pgdat_list; pgdat; pgdat = pgdat->pgdat_next)
*/
