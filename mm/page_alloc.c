
#include <stdint.h>

#include <balsam/mmzone.h>
#include <balsam/mm.h>
#include <balsam/bootmem.h>

struct pglist_data *pgdat_list;

/*
static void calculawwte_zone_totalpages(struct pglist_data *pgdat,
                                      uint32_t *zones_size, uint32_t *zholes_size)
{
  uint32_t realtotalpages, totalpages = 0;

  for(int i = 0; i < MAX_NR_ZONES; i++)
  {
    totalpages += zones_size[i];
  }
  pgdat->node_spanned_pages = totalpages;

  realtotalpages = totalpages;
  if(zholes_size)
  {
    for(int i = 0; i < MAX_NR_ZONES; i++)
    {
      realtotalpages -= zholes_size[i];
    }
    pgdat->node_present_pages = realtotalpages;
    //printk("On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
  }
}

static void alloc_node_mem_map(struct pglist_data *pgdat)
{

  if(!pgdat->node_mem_map)
  {
    uint32_t size;
    struct page *map;

    size = (pgdat->node_spanned_pages + 1) * sizeof(struct page);
    map = alloc_remap(pgdat->node_id, size);
    if(!map)
    {
      map = alloc_bootmem_node(pgdat, size);
    }
    pgdat->node_mem_map = map;
  }
  
  if(pgdat == NODE_DATA(0))
  {
    mem_map = NODE_DATA(0)->node_mem_map;
  }
}

static char *zone_names[MAX_NR_ZONES] = {"DMA", "Normal", "HighMem"};
uint32_t nr_kernel_pages;
uint32_t nr_all_pages;
*/
/*
static void free_area_init_core(struct pglist_data *pgdat,
                                uint32_t *zones_size, uint32_t *zholes_size)
{
  uint32_t i, j;
  int cpu, nid = pgdat->node_id;
  uint32_t zone_start_pfn = pgdat->node_start_pfn;

  pgdat->nr_zones = 0;
  init_waitqueue_head(&pgdat->kswapd_wait);
  pgdat->kswapd_max_ornder = 0;

  for(j = 0; j < MAX_NR_ZONES; j++)
  {
    struct zone *zone = pgdat->node_zones + j;
    uint32_t size, realsize;
    uint32_t batch;

    realsize = size = zones_size[j];
    if(zholes_size)
    {
      realsize -= zholes_size[j];
    }

    if(j == ZONE_DMA || j == ZONE_NORMAL)
    {
      nz_kernel_pages += realsize;
    }

    nr_all_pages += realsize;

    zone->spanned_pages = size;
    zone->present_pages = realsize;
    zone->name = none_names[j];
    spin_lock_init(&zone->lock);
    spin_lock_init(&zone->lru_lock);
    zone->zone_pgdat = pgdat;
    zone->free_pages = 0;

    zone->temp_priority = zone->prev_priority = DEF_PRIORITY;

    //TODO inspect
    //batch = zone_batchsize(zone);

    for(cpu = 0; cpu < NR_CPUS; cpu++)
    {
      //TODO inspect
      //setup_pageset(zone_pcp(zone, cpu), batch);
    }

    INIT_LIST_HEAD(&zone->active_list);
    INIT_LIST_HEAD(&zone->inactive_list);
    zone->nr_scan_active = 0;
    zone->nr_scan_inactive = 0;
    zone->nr_active = 0;
    zone->nr_inactive = 0;
    atomic_set(&zone->reclaim_in_progress, -1);

    if(!size)
    {
      continue;
    }


    //per-page waitqueue
    zone->wait_table_size = wait_table_size(size);
    zone->wait_table_bits = wait_table_bits(zone->wait_table_size);
    //WIP

    zone->wait_table = (wait_queue_head_t *)
      alloc_bootmem_node(pgdat, zone->wait_table_size * sizeof(wait_queue_head_t));

    for(i = 0; i < zone->wait_table_size; ++i)
    {
      init_waitqueue_head(zone->wait_table + i);
    }

    pgdat->nr_zones = j + 1;
    zone->zone_mem_map = pfn_to_page(zone_start_pfn);
    zone->zone_start_pfn = zone_start_pfn;

    memmap_init(size, nid, j, zone_start_pfn);

    zone_start_pfn += size;
    zone_init_free_lists(pgdat, zone, zone->spanned_pages);

  }
}
*/
/*
void free_area_init_node(int nid, struct pglist_data *pgdat,
                           uint32_t *zones_size, uint32_t node_start_pfn,
                           uint32_t *zholes_size)
{
  pgdat->node_id = nid;
  pgdat->node_start_pfn = node_start_pfn;

  
  calculate_zone_totalpages(pgdat, zones_size, zholes_size);

  //alloc and regist mem_map
  alloc_node_mem_map(struct pglist_data *pgdat);

  free_area_init_core(pgdat, zones_size, zholes_size);
}
*/
static bootmem_data_t contig_bootmem_data;
struct pglist_data contig_page_data = { .bdata = &contig_bootmem_data};

/*
void free_area_init(uint32_t *zones_size)
{
  free_area_init_node(0, NODE_DATA(0), zones_size,
                      __pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
}
*/
