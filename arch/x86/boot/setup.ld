OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
OUTPUT_ARCH(i386)
ENTRY(_start)

SECTIONS 
{
    . = 0;
    .bstext : { *(.bstext)}
    .bsdata : { *(.bsdata)}
    
    . = 0x1f1;
    .setup_sects : { *(.setup_sects)}

    . = 0x1fe;
    .boot_flag : { *(.boot_flag)}

    .text : { *(.text)}
}
