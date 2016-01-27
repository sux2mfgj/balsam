#include <balsam/bootmem.h>
#include <balsam/kernel.h>

#include <asm-i386/io.h>
#include <asm-i386/string.h>
#include <asm-i386/bitops.h>

uint32_t min_low_pfn;
uint32_t max_low_pfn;
uint32_t max_pfn;

static uint32_t init_bootmem_core(pg_data_t *pgdat,
                                  uint32_t mapstart, uint32_t start, uint32_t end)
{
  bootmem_data_t *bdata = pgdat->bdata;

  uint32_t mapsize = ((end - start) + 7) / 8;

  pgdat->pgdat_next = pgdat_list;
  pgdat_list = pgdat;

  mapsize = ALIGN(mapsize, sizeof(int32_t));
  bdata->node_bootmem_map = phys_to_virt(mapstart << PAGE_SHIFT);
  bdata->node_boot_start = (start << PAGE_SHIFT);
  bdata->node_low_pfn = end;

  memset(bdata->node_bootmem_map, 0xff, mapsize);

  return mapsize;
}

uint32_t init_bootmem(uint32_t start, uint32_t pages)
{
  max_low_pfn = pages;
  min_low_pfn = start;

  return(init_bootmem_core(NODE_DATA(0), start, 0, pages));
}


static void free_bootmem_core(bootmem_data_t *bdata, uint32_t addr, uint32_t size)
{
  uint32_t start;
  uint32_t sidx;
  uint32_t eidx = (addr + size - bdata->node_boot_start) / PAGE_SIZE;
  //  uint32_t end = (addr + size) / PAGE_SIZE;

  start = (addr + PAGE_SIZE - 1) / PAGE_SIZE;
  sidx = start - (bdata->node_boot_start / PAGE_SIZE);

  for(int i = sidx; i < eidx; ++i)
  {
    if(!test_and_clear_bit(i, bdata->node_bootmem_map))
    {
      panic("BUG");
    }
  }
}

void free_bootmem(uint32_t addr, uint32_t size)
{
  free_bootmem_core(NODE_DATA(0)->bdata, addr, size);
}

static void reserve_bootmem_core(bootmem_data_t *bdata, uint32_t addr, uint32_t size)
{
  uint32_t sidx = (addr - bdata->node_boot_start) / PAGE_SIZE;
  uint32_t eidx = (addr + size - bdata->node_boot_start + PAGE_SIZE - 1) /PAGE_SIZE;
  //  uint32_t end = (addr + size + PAGE_SIZE - 1) / PAGE_SIZE;

  for(uint32_t i = sidx; i < eidx; ++i)
  {
    if(test_and_set_bit(i, bdata->node_bootmem_map))
    {
      //printk("already reserved");
    }
  }
}

void reserve_bootmem(uint32_t addr, uint32_t size)
{
  reserve_bootmem_core(NODE_DATA(0)->bdata, addr, size);
}

/*
static void * __alloc_bootmem_core(struct bootmem_data *bdata, uint32_t size,
                                   uint32_t align, uint32_t goal)
{
  uint32_t offset, remaining_size, areasize, preferred;
  uint32_t i, start = 0, incr, eidx;
  void *ret;

  eidx = bdata->node_low_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
  offset = 0;

  //TODO align
//if(align &&
//     (bdata->node_boot_start & (align - 1UL)) != 0)
//    {
//      offset = (align - (bdata->node_boot_start & (align - 1UL)));
//    }
//
  offset >>= PAGE_SHIFT;

  //TODO goal
  
//  if(goal && (goal >= bdata->node_boot_start) &&
//     ((goal >> PAGE_SHIFT) < bdata->node_low_pfn))
//    {
//      preferred = goal - bdata->node_boot_start;

//      if(bdata->last_success >= preferred)
//        {
//          preferred = bdata->list_success;
//        }
//    }
//  else {
//    preferred = 0;
//  }

  preferred = 0;
  //preferred = ALIGN(prefer, align) >> PAGE_SHIFT;
  preferred += offset;
  areasize = (size + PAGE_SIZE - 1) / PAGE_SIZE;
  //incr = align >> PAGE_SHIFT ? : 1;

  incr = 1;

restart_scan:
  for(int i = preferred; i < eidx; i += incr)
  {
    uint32_t j;
    i = find_next_zero_bit(bdata->node_bootmem_map, eidx, i);
    i = ALIGN(i, incr);
    if(test_bit(i, bdata->node_bootmem_map))
    {
      continue;
    }

    for(j = i + 1; j < i + areasize; ++j)
    {
      if (j >= eidx)
      {
        goto fail_block;
      }
      if (test_bit(j, bdata->node_bootmem_map))
      {
        goto fail_block;
      }
    }

    start = i;
    goto found;

  fail_block:
    i = ALIGN(j, incr);
  }

  return NULL;

found:
  bdata->last_success = start << PAGE_SHIFT;

  //TODO
  //if(align ....)..

  bdata->last_pos = start + areasize - 1;
  bdata->last_offset = size & ~PAGE_MASK;
  ret = phys_to_virt(start * PAGE_SIZE + bdata->node_boot_start);

  //reserve the area now

  for(int i = start; i < start + areasize; i++)
  {
    if(test_and_set_bit(i, bdata->node_bootmem_map))
      {
        BUG();
      }
  }
  memset(ret, 0, size);
  return ret;
}

void * __alloc_bootmem(uint32_t size, uint32_t align, uint32_t goal)
{
  pg_data_t *pgdat = pgdat_list;
  void *ptr;

  for_each_pgdat(pgdat) {
    if((ptr = __alloc_bootmem_core(pgdat->bdata, size, align, goal))){
      return(ptr);
    }
  }
  panic("out of memory");
}

*/
