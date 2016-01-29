
#include <asm-i386/bitops.h>

int find_next_zero_bit(const uint32_t *addr, int size, int offset)
{

  const uint8_t bit = 0b00000001;
  for(int i=0; i < size; ++i)
  {
    //int shift_size = 8 % i;
    if(!*(addr + (i / 8)) & (bit << (i % 8)))
    {
      return i;
    }
  }
  return -1;
}
