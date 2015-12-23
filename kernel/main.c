#include <stdint.h>
#include <stdbool.h>

/* extern void io_hlt(void); */
#define VRAM_TEXT_MODE  0x000B8000

void start_kernel(void)
{
    uint16_t *vran_text_mode = (uint16_t*)VRAM_TEXT_MODE;

    *vran_text_mode = (0x07 << 8) | 'A';

    while(true){
/*         io_hlt(); */
    }
}
