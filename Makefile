ARCH		:= 	i386

CC			:= 	clang
#  CC			:= 	gcc
LD 			:= 	ld

QEMU		:= qemu-system-i386

CFLAGS		:=	-Wall -O0 --target=i686-elf -ggdb3
LDFLAGS		:=  -m elf_i386 --oformat binary 
DEBUG_LDFLAGS := -m elf_i386
#  QEMUEXTRA 	:= 	-curses
#QEMUEXTRA 	:= 	-serial mon:stdio	
#  QEMUFLAGS	:= 	-monitor stdio -m 16M -nographic -gdb tcp::10000 -S $(QEMUEXTRA)
#  QEMUFLAGS	:= 	-m 16M -nographic -gdb tcp::10000 -S $(QEMUEXTRA)
QEMUFLAGS	:= 	-m 896M -gdb tcp::10000 -S $(QEMUEXTRA)

IMAGE		:= 	balsam

ARCH_PATH 	:= 	arch/$(ARCH)

BOOT_PATH	:= 	$(ARCH_PATH)/boot
BOOTIMG		:= 	$(BOOT_PATH)/boot.img

KERNEL_PATH	:= 	$(ARCH_PATH)/kernel
KERNELIMG	:= 	$(KERNEL_PATH)/kernel.img

DEBUG_OBJ 	:= 	kernel.debug

LDSCRIPT 	:= 	$(ARCH_PATH)/kernel/kernel.ld

arch_objs 	:=  kernel/head_32.o kernel/setup.o kernel/init_task.o mm/init.o lib/memcpy.o lib/bitops.o
init_objs 	:=  main.o
mm_objs		:=  bootmem.o page_alloc.o memory.o
kernel_objs	:=  printk.o panic.o 

OBJS := $(foreach file, $(arch_objs), $(ARCH_PATH)/$(file)) \
	$(foreach file, $(init_objs), init/$(file)) \
	$(foreach file, $(mm_objs), mm/$(file)) \
	$(foreach file, $(kernel_objs), kernel/$(file))

.c.o: 
	$(CC) $(CFLAGS) -Iinclude -I$(ARCH_PATH)/include $< -c -o $@
.S.o: 
	$(CC) $(CFLAGS) -Iinclude -I$(ARCH_PATH)/include $< -c -o $@

all: $(IMAGE) $(DEBUG_OBJ)

$(IMAGE): $(BOOTIMG) $(KERNELIMG)
	cat $(BOOTIMG) $(KERNELIMG) > $@

$(BOOTIMG):
	cd $(BOOT_PATH); $(MAKE);

$(KERNELIMG): $(OBJS) $(LDSCRIPT)
	$(LD) $(LDFLAGS) $(OBJS) -o $@ -T $(LDSCRIPT) 

$(LDSCRIPT): $(LDSCRIPT).S
	$(CC) -P -E $< -o $(LDSCRIPT) -Iinclude/ -I./arch/$(ARCH)/include

$(DEBUG_OBJ): $(OBJS) $(LDSCRIPT)
	$(LD) $(DEBUG_LDFLAGS) $(OBJS) -o $@ -T $(LDSCRIPT)

run: $(IMAGE)
	$(QEMU) $(QEMUFLAGS) -fda $(IMAGE)

clean:
	cd $(BOOT_PATH); $(MAKE) clean
	rm -f $(IMAGE) $(OBJS) $(LDSCRIPT) $(DEBUG_OBJ)
