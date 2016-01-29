#pragma once

#include <asm-i386/fixmap.h>
#include <asm-i386/pgtable-2level-defs.h>
#include <asm-i386/page.h>

#ifndef __ASSEMBLY__

extern unsigned long pg0[];

//TODO fix VMALLOC_END
//#define VMALLOC_END (PKMAP_BASE - 2 * PAGE_SIZE)
#define VMALLOC_END (FIXADDR_START - 2 * PAGE_SIZE)

#define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
void paging_init(void);

#define pmd_none(x) (!pmd_val(x))

#define _PAGE_PRESENT	0x001
#define _PAGE_RW	0x002
#define _PAGE_USER	0x004
#define _PAGE_PWT	0x008
#define _PAGE_PCD	0x010
#define _PAGE_ACCESSED	0x020
#define _PAGE_DIRTY	0x040
#define _PAGE_PSE	0x080	/* 4 MB (or 2MB) page, Pentium+, if present.. */
#define _PAGE_GLOBAL	0x100	/* Global TLB entry PPro+ */
#define _PAGE_UNUSED1	0x200	/* available for programmer */
#define _PAGE_UNUSED2	0x400
#define _PAGE_UNUSED3	0x800

#define _PAGE_TABLE (_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | _PAGE_ACCESSED | _PAGE_DIRTY)

#define _PAGE_NX 0

#define __PAGE_KERNEL_EXEC \
  (_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_ACCESSED)

#define __PAGE_KERNEL \
  (_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_NX)

#define PAGE_KERNEL_EXEC __pgprot(__PAGE_KERNEL_EXEC)
#define PAGE_KERNEL __pgprot(__PAGE_KERNEL)


#define pte_index(address) \
  (((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))

#define pte_offset_kernel(dir, address) \
  ((pte_t *)pmd_page_kernel(*(dir)) + pte_index(address))

#endif // !__ASSEMBLY__

