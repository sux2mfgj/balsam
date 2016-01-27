#pragma once 

#include <stdint.h>
#include <stddef.h>

#include <balsam/mmzone.h>

extern uint32_t min_low_pfn;
extern uint32_t max_low_pfn;
extern uint32_t max_pfn;

typedef struct bootmem_data
{
  uint32_t node_boot_start;
  uint32_t node_low_pfn;
  void *node_bootmem_map;
  uint32_t last_offset;
  uint32_t last_pos;
  uint32_t last_success;
} bootmem_data_t;


static inline void *alloc_remap(int nid, uint32_t size)
{
  return NULL;
}

extern uint32_t init_bootmem(uint32_t addr, uint32_t memend);
extern void free_bootmem(uint32_t addr, uint32_t size);

extern void reserve_bootmem(uint32_t addr, uint32_t size);
//extern 
