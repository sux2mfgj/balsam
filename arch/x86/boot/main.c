#include <asm/boot.h>
#include <asm/string.h>
#include <asm/segment.h>

#include <stdint.h>

struct gdt_ptr {
	uint16_t len;
	uintptr_t ptr;
} __attribute__((packed));

static void setup_gdt(void)
{

    // flat memory model
	static const uint64_t boot_gdt[] __attribute__((aligned(16))) = {
	    [GDT_ENTRY_BOOT_CS] = GDT_ENTRY(0xc09b, 0, 0xfffff), 
	    [GDT_ENTRY_BOOT_DS] = GDT_ENTRY(0xc093, 0, 0xfffff),
	};
	static struct gdt_ptr gdt;

	gdt.len = sizeof(boot_gdt)-1;
	gdt.ptr = (uintptr_t)&boot_gdt;

	asm volatile("lgdtl %0" : : "m" (gdt));
}

static void setup_idt(void)
{
	static const struct gdt_ptr null_idt = {0, 0};
	asm volatile("lidtl %0" : : "m" (null_idt));
}

void main(void)
{
    setup_idt();
    setup_gdt();
    protected_mode_jump();
    //don't reach this line
}


