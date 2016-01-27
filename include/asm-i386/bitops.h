#pragma once
#include <stdint.h>

static inline int test_and_clear_bit(int nr, uint8_t *addr)
{
  uint8_t bit_place = nr % 8;
  if(nr > 7) {
    addr += (nr / 8);
  }
  int oldbit = *addr & (0x1 << bit_place);

  //  uint8_t val = *addr;
  *addr &= ~(0x1 << bit_place);
  
  return oldbit;
}

/*static inline int test_and_clear_bit(int nr, volatile uint32_t * addr)
{
  int oldbit;
  __asm__ __volatile__ (
                        "btrl %2,%1\n\tsbbl %0,%0"
                        :"=r" (oldbit), "=m"(addr)
                        :"Ir" (nr) : "memory"
                        );
    return oldbit;
    }*/

static inline int test_and_set_bit(int nr, volatile uint32_t * addr)
{
  int oldbit;
  __asm__ __volatile__(
                       "btsl %2,%1\n\tsbbl %0,%0"
                       :"=r" (oldbit), "=m" (addr)
                       :"Ir" (nr) : "memory"
                       );
  return oldbit;
}
