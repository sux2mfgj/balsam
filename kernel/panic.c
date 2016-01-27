#include <stddef.h>
#include <stdbool.h>

#include <balsam/kernel.h>


void panic(const char * fmt, ...)
{
  printk("panic");
  while(true)
    {
    }
}
