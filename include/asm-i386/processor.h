#pragma once

#define load_cr3(pgdir) \
  asm volatile("movl %0, %%cr3": :"r"(__pa(pgdir)))
