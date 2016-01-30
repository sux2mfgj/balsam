#pragma once

#define E820MAX 128

#define E820_RAM        1
#define E820_RESEVED    2
#define E820_ACPI       3
#define E820_NVS        4

#ifndef __ASSEMBLY__

struct e820map {
    int nr_map;
    struct e820entry {
        uint64_t addr;
        uint64_t size;
        uint32_t type;
    } map[E820MAX];
};

extern struct e820map e820;

#endif //__ASSEMBLY__
