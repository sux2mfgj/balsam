#pragma once

#define ALIGN(x, a) (((x) + (a)-1) & ~((a)-1))

int printk(const char *fmt, ...);
void panic(const char *fmt, ...);

#define min(x, y)           \
    ({                      \
        typeof(x) _x = (x); \
        typeof(y) _y = (y); \
        (void)(&_x == &_y); \
        _x < _y ? _x : _y;  \
    })

#define max(x, y)           \
    ({                      \
        typeof(x) _x = (x); \
        typeof(y) _y = (y); \
        (void)(&_x == &_y); \
        _x > _y ? _x : _y;  \
    })
