OUTPUT_FORMAT("elf32-i386")
OUTPUT_ARCH(i386)

SECTIONS 
{
/*    . = 0;
    .setup_text : { *(.setup_text)}
    .setup_data : { *(.setup_data)}
    */
    . = 0;
    .text : { *(.text)}

    . = 510;
    .boot_flag : { *(.boot_flag)}

    . = 512;
    .setup_text : { *(.setup_text)}
    .setup_data : { *(.setup_data)}

}
