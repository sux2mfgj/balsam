#pragma once

#include <stddef.h>

#define __flush_tlb() \
  do {                                          \
    uint32_t tmpreg;                            \
   __asm__ __volatile__ (                          \
                         "movl %%cr3, %0;"         \
                         "movl %0, %%cr3;"         \
                         : "=r" (tmpreg)           \
                         :: "memory");             \
  } while(0)  

#define __flush_tlb_all()                       \
  __flush_tlb()



/*
  do {
     if(cpu_has_pge)
        __flush_tlb_global();
     else
        __flush_tlb();
  }while(0)
 */
