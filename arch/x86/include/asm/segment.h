#pragma once

#define GDT_ENTRY(flags, base, limit)			\
	((((base)  & 0xff000000ULL) << (56-24)) |	\
	 (((flags) & 0x0000f0ffULL) << 40) |		\
	 (((limit) & 0x000f0000ULL) << (48-16)) |	\
	 (((base)  & 0x00ffffffULL) << 16) |		\
	 (((limit) & 0x0000ffffULL)))


#define GDT_ENTRY_BOOT_CS 2
#define __BOOT_CS (GDT_ENTRY_BOOT_CS * 8)

#define GDT_ENTRY_BOOT_DS (GDT_ENTRY_BOOT_CS + 1)
#define __BOOT_DS (GDT_ENTRY_BOOT_DS * 8)

