#pragma once

#include <asm-i386/fixmap.h>
#include <asm-i386/pgtable-2level-defs.h>

#ifndef __ASSEMBLY__

extern unsigned long pg0[];

//TODO fix VMALLOC_END
//#define VMALLOC_END (PKMAP_BASE - 2 * PAGE_SIZE)
#define VMALLOC_END (FIXADDR_START - 2 * PAGE_SIZE)

#define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
void paging_init(void);

#define pmd_none(x) (!pmd_val(x))

#endif // !__ASSEMBLY__

