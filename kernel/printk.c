#include <balsam/kernel.h>
#include <stdint.h>

#define VRAM_TEXT_MODE  0x000B8000

/*     uint16_t *vran_text_mode = (uint16_t*)VRAM_TEXT_MODE; */
/*     *vran_text_mode = (0x07 << 8) | 'A'; */

uint32_t current_position_x = 0, current_position_y = 0;
const uint32_t max_width = 80, max_heigh = 25;

int printk(const char *fmt, ...)
{
  volatile char *video = (volatile char*)VRAM_TEXT_MODE;
  uint32_t length = 0;

  while(*fmt != 0)
  {
    *(video + (max_width * current_position_y) + (2 *length++)) = (0x07 << 8) | *fmt++;
  }
  current_position_y++;
  if(current_position_y >= max_heigh)
  {
    //TODO
  }

  return length;
}
