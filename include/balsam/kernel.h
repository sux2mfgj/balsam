#pragma once


#define ALIGN(x,a) (((x)+(a)-1)&~((a)-1))

int printk(const char *fmt, ...);
void panic(const char *fmt, ...);

