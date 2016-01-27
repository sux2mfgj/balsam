#pragma once

#include <stddef.h>

static inline void * __memcpy(void* to, const void* from, size_t n)
{
    int d0, d1, d2;
    asm volatile(
        "rep ; movsl\n\t"
        "movl %4, %%ecx\n\t"
        "andl $3, %%ecx\n\t"
        "jz 1f\n\r"
        "rep ; movsb\n\t"
        "1:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        : "0" (n/4), "g" (n), "1" ((long)to), "2" ((long)from)
        : "memory");

    return to;
}


#define memcpy(t, f, n) __memcpy((t), (f), (n))

//TODO:
//KMEMCHECK 
// #define memcpy(t, f, n)             \
//     (__builtin_constant_p((n))      \
//      ? __constant_memcpy((t), (f), (n)) \
//      : __memcpy((t), (f), (n)))
