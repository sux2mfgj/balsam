#include <stdint.h>

#include <asm/setup.h>
#include <asm-i386/page.h>
#include <asm-i386/setup.h>
#include <asm-i386/e820.h>

#include <balsam/init.h>
#include <balsam/bootmem.h>

unsigned long init_pg_tables_end = ~0UL;

struct e820map e820 = {
    .nr_map  =  1,
    .map = {
        //[mem 0x0000000000000000-0x000000000009fbff] usable
        {
            .addr = 0x00000000,
            .size = 0x0009fbff,
            .type = E820_RAM,
        },
        //[mem 0x000000000009fc00-0x000000000009ffff] reserved
        {
            .addr = 0x0009fc00,
            .size = 0x0009ffff - 0x0009fc00,
            .type = E820_RESEVED,
        },
        //[mem 0x00000000000f0000-0x00000000000fffff] reserved
        {
            .addr = 0x000f0000,
            .size = 0x000fffff - 0x000f0000,
            .type = E820_RESEVED,
        },
        //[mem 0x0000000000100000-0x000000007ffd8fff] usable
        {
            .addr = 0x00100000,
            .size = 0x7ffd8fff - 0x00100000,
            .type = E820_RAM,
        },
        //[mem 0x000000007ffd9000-0x000000007fffffff] reserved
        {
            .addr = 0x7ffd9000,
            .size = 0x7fffffff - 0x7ffd9000,
            .type = E820_RESEVED,
        },
        //[mem 0x00000000feffc000-0x00000000feffffff] reserved
        {
            .addr = 0xfeffc000,
            .size = 0xfeffffff - 0xfeffc000,
            .type = E820_RESEVED,
        },
        //[mem 0x00000000fffc0000-0x00000000ffffffff] reserved
        {
            .addr = 0xfffc0000,
            .size = 0xffffffff - 0xfffc0000,
            .type = E820_RESEVED,
        },
    }
};

void find_max_pfn(void)
{
    max_pfn = 0;
    for(int i=0; i < e820.nr_map; ++i)
    {
        uint32_t start, end;
        if(e820.map[i].type != E820_RAM)
        {
            continue;
        }

        start = PFN_UP(e820.map[i].addr);
        end = PFN_DOWN(e820.map[i].addr + e820.map[i].size);

        if(start >= end)
        {
            continue;
        }

        if(end > max_pfn) 
        {
            max_pfn = end;
        }
    }

}

uint32_t find_max_low_pfn(void)
{
    uint32_t max_low_pfn;
    max_low_pfn = max_pfn;


}

static uint32_t setup_memory(void)
{
    // for e820

    min_low_pfn = PFN_UP(init_pg_tables_end);

    find_max_pfn();

    max_low_pfn = find_max_low_pfn();
   
    return max_low_pfn;
}

void setup_arch(void)
{
    max_low_pfn = setup_memory();
}
