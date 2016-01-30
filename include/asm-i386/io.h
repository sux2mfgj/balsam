#pragma once

#include <asm-i386/page.h>

static inline uint32_t virt_to_phys(volatile void * address)
{
  return __pa(address);
}

static inline void * phys_to_virt(uint32_t address)
{
  return __va(address);
}
