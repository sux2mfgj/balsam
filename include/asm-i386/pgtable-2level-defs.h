#pragma once

#define PGDIR_SHIFT 22
#define PTRS_PER_PGD 1024

#define PTRS_PER_PTE 1024

#define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
#define set_pte(pteptr, pteval) (*(pteptr) = pteval)

#define pfn_pte(pfn, prot) __pte(((pfn)<< PAGE_SHIFT) | pgprot_val(prot))

#define pmd_page_kernel(pmd) \
  ((uint32_t)__va(pmd_val(pmd) & PAGE_MASK))
