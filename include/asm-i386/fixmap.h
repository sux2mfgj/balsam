#pragma once

#define __FIXADDR_TOP 0xfffff000

#ifndef __ASSEMBLY__

//TODO
enum fixed_addresses {
  FIX_HOLE,

  //TODO
  //  FIX_KMAP_BEGIN,
  //  FIX_KMAP_END,

  __end_of_permanent_fixed_addresses,

  __end_of_fixed_addresses,
};

#define FIXADDR_TOP ((uint32_t)__FIXADDR_TOP)

#endif

#define __FIXADDR_SIZE (__end_of_permanent_fixed_addresses << PAGE_SHIFT)
#define __FIXADDR_BOOT_SIZE (__end_of_fixed_addresses << PAGE_SHIFT)

//TODO
// #define FIXADDR_START (FIXADDR_TOP - __FIXADDR_SIZE)
#define FIXADDR_START FIXADDR_TOP

#define FIXADDR_BOOT_START (FIXADDR_TOP - __FIXADDR_BOOT_SIZE)
