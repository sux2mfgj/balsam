#include <asm-i386/string.h>

void *memset(void *s, int c, size_t count)
{
  return __memset_generic(s, c, count);
}
