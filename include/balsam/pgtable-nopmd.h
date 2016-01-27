#pragma once


static inline pmd_t * pmd_offset(pud_t* pud, uint32_t address)
{
  return (pmd_t *)pud;
}

#define pmd_val(x)  (pud_val((x).pud))
