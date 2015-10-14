#ifndef _INCLUDED_UTIL_H_
#define _INCLUDED_UTIL_H_

static inline void hlt(void)
{
    asm volatile("hlt");
}

extern inline void protected_mode_jump(void);
static inline void temp_kernel_load(void);

#endif
