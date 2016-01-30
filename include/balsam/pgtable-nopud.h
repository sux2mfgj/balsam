#pragma once

#ifndef __ASSEMBLY__

#define PMD_SHIFT PUD_SHIFT
#define PTRS_PER_PMD 1
#define PMD_SIZE (1UL << PMD_SHIFT)
#define PMD_MASK (~(PMD_SIZE - 1))

typedef struct { pgd_t pgd;} pud_t;
typedef struct { pud_t pud;} pmd_t;

static inline pud_t * pud_offset(pgd_t* pgd, uint32_t address)
{
  return (pud_t*)pgd;
}

#define pud_val(x)  (pgd_val((x).pgd))

#endif //!__ASSEMBLY__
