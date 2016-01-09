#pragma once

#ifndef __ASSEMBLY__

struct thread_info {
    struct task_struct *task;
};

#endif //__ASSEMBLY__

#define THREAD_SIZE (8192)
