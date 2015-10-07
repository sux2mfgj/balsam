OUTPUT_FORMAT("elf32-i386")
OUTPUT_ARCH(i386)

SECTIONS 
{
    . = 0;
    .bstext :{ *(.bstext) }
    .bsdata :{ *(.bsdata) }

    . = 510;
    .bootflag :{ *(.bootflag) }

    .text :{*(.text)}
}
