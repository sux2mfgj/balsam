#pragma once

typedef struct { volatile int counter;} atomic_t;


#define atomic_set(v, i) (((v)->counter) = i)
#define atomic_read(v) ((v)->counter)

static inline void atomic_add(int i, atomic_t *v)
{
  __asm__ __volatile__(
                       "addl %1, %0"
                       : "=m" (v->counter)
                       : "ir" (i), "m" (v->counter));
}
