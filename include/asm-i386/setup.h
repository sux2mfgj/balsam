#pragma once


#define PFN_UP(x)   (((x) + PAGE_SIZE - 1) >> PAGE_SHIFT)
#define PFN_DOWN(x) ((x) >> PAGE_SHIFT)
#define PFN_PHYS(x) ((x) << PAGE_SHIFT)

// extern unsigned long init_pg_tables_end;

#define E820_MAP_NR (*(char *) (PARAM + E820NR))
#define E820_MAP (())

#define MAXMEM_PFN PFN_DOWN(MAXMEM)

