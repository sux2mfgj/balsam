#include <stdint.h>
#include <stdbool.h>

#include <asm-i386/pgtable.h>
#include <balsam/init.h>

/* extern void io_hlt(void); */
#define VRAM_TEXT_MODE  0x000B8000

void start_kernel(void)
{
    //TODO
    //- memblock_init (mm/memblock.c)
    //- page_address_init
    //- setup_arch
    //...
   
/*     uint16_t *vran_text_mode = (uint16_t*)VRAM_TEXT_MODE; */

/*     *vran_text_mode = (0x07 << 8) | 'A'; */

    setup_arch();

    while(true){
    }

}
