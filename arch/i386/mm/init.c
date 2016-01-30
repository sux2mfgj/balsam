#include <stdint.h>

#include <asm-i386/pgtable-2level-defs.h>
#include <asm-i386/page.h>
#include <asm-i386/pgtable.h>
#include <asm-i386/processor.h>
#include <asm-i386/tlbflush.h>


#include <balsam/pgtable-nopud.h>
#include <balsam/pgtable-nopmd.h>
#include <balsam/bootmem.h>

uint32_t __VMALLOC_RESERVE = 128 << 20;

uint32_t highstart_pfn, highend_pfn;

extern char __init_begin, __init_end;

static pmd_t* one_md_table_init(pgd_t *pgd)
{
  pud_t *pud;
  pmd_t *pmd_table;

  //TODO PAE
  
  pud = pud_offset(pgd, 0);
  pmd_table = pmd_offset(pud, 0);

  return pmd_table;
}

static pte_t* one_page_table_init(pmd_t* pmd)
{
  if(pmd_none(*pmd))
  {
    pte_t *page_table = (pte_t*)alloc_bootmem_low_pages(PAGE_SIZE);
    set_pmd(pmd, __pmd(__pa(page_table) | _PAGE_TABLE));
    if(page_table != pte_offset_kernel(pmd, 0))
    {
      panic();
    }
    return page_table;
  }
  return pte_offset_kernel(pmd, 0);
}

static inline int is_kernel_text(uint32_t addr)
{
  if(addr >= PAGE_OFFSET && addr <= (uint32_t)__init_end)
    return 1;

  return 0;
}

static void kernel_physical_mapping_init(pgd_t *pgd_base)
{
  uint32_t pfn;
  pgd_t *pgd;
  pmd_t *pmd;
  
  pte_t *pte;

  int pgd_idx, pmd_idx, pte_ofs;

  pgd_idx = pgd_index(PAGE_OFFSET);
  pgd = pgd_base + pgd_idx;
  pfn = 0;

  for(;pgd_idx < PTRS_PER_PGD; pgd++, pgd_idx++)
  {

    //    for(pgd_idx = )
    
    pmd = one_md_table_init(pgd);

    if(pfn >= max_low_pfn)
    {
      continue;
    }

    for(pmd_idx = 0; pmd_idx < PTRS_PER_PMD && pfn < max_low_pfn; pmd++, pmd_idx++)
    {
      uint32_t address = pfn * PAGE_SIZE + PAGE_OFFSET;

      //TODO
      //if(cpu_has_pse)
      //{}
      //else{
      pte = one_page_table_init(pmd);
      for(pte_ofs = 0; pte_ofs < PTRS_PER_PTE && pfn < max_low_pfn; pte++, pfn++, pte_ofs++)
      {
        if(is_kernel_text(address))
        {
          set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC));
        }
        else
        {
          set_pte(pte, pfn_pte(pfn, PAGE_KERNEL));
        }
      }
      //}
    }

  }
  
}

static void pagetable_init(void)
{
  uint32_t vaddr;
  pgd_t *pgd_base = swapper_pg_dir;

  //TODO x86 cpu PSE(page size extension), PGE(page global enbale)

  kernel_physical_mapping_init(pgd_base);

  //TODO
  // setup for fixed mappings.
  // vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
  // page_table_range_init(vaddr, 0, pgd_base);
  // permanent_kmaps_init(pgd_base);
}

void paging_init(void)
{
  pagetable_init();
  load_cr3(swapper_pg_dir);

  __flush_tlb_all();

  //TODO setup highmem
  //kmap_init();
}


