#pragma once

#include <asm-i386/thread_info.h>

union thread_union {
  //TODO when I use, below code enable.
  //struct thread_info thread_info;
	uint32_t stack[THREAD_SIZE/sizeof(uint32_t)];
};
