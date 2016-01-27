#pragma once

#include <stddef.h>
// #define memset(s, c, count) \
//   (__memset_generic((s), (c), (count)))

void *memset(void *s, int c, size_t count);

static inline void * __memset_generic(void *s, char c, size_t count)
{
  int d0, d1;
  __asm__ __volatile__(
                       "rep\n\t"
                       "stosb"
                       : "=&c" (d0), "=&D" (d1)
                       : "a" (c), "1" (s), "0" (count)
                       : "memory"
                       );

  return s;
}
