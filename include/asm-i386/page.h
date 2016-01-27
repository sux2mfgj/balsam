#pragma once

#include <asm-i386/pgtable.h>

#define PAGE_SHIFT  12
#define PAGE_SIZE   (1UL << PAGE_SHIFT)
#define PAGE_MASK   (~(PAGE_SIZE - 1))

#define __PAGE_OFFSET       (0xC0000000)

#ifndef __ASSEMBLY__

extern uint32_t __VMALLOC_RESERVE;

#define PAGE_OFFSET ((uint32_t)__PAGE_OFFSET)

#define VMALLOC_RESERVE ((uint32_t)__VMALLOC_RESERVE)
#define MAXMEM (VMALLOC_END - PAGE_OFFSET - __VMALLOC_RESERVE)

#define __pa(x) ((uint32_t)(x) - PAGE_OFFSET)
#define __va(x) ((void *)((uint32_t)(x) + PAGE_OFFSET))


typedef struct {uint32_t pgd;} pgd_t;
typedef struct {uint32_t pte_low;} pte_t;

#define pgd_val(x) ((x).pgd)

#endif //!__ASSEMBLY__

