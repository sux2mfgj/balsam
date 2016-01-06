#pragma once

#define __ALIGN .align 16,0x90

#define ALIGN __ALIGN

#define ENTRY(name)\
    .globl name; \
    ALIGN; \
    name:

