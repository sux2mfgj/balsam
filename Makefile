ARCH		:= 	x86

CC			:= 	clang
LD 			:= 	ld

QEMU		:= qemu-system-i386

CFLAGS		:=	-Wall -ggdb3 -O0 --target=i686-elf
LDFLAGS		:=  -m elf_i386 --oformat binary 
QEMUFLAGS	:= 	-monitor stdio -m 16M -nographic -curses -gdb tcp::10000 -S


IMAGE		:= 	balsam

BOOT_PATH	:= 	arch/$(ARCH)/boot
BOOTIMG		:= 	$(BOOT_PATH)/boot.img

KERNEL_PATH	:= 	kernel
KERNELIMG	:= 	$(KERNEL_PATH)/kernel.img



all: $(IMAGE)

$(IMAGE): $(BOOTIMG) $(KERNELIMG)
	cat $(BOOTIMG) $(KERNELIMG) > $@

$(KERNELIMG):
	cd $(KERNEL_PATH); $(MAKE)

$(BOOTIMG):
	cd $(BOOT_PATH); $(MAKE)

run: $(IMAGE)
	$(QEMU) $(QEMUFLAGS) -fda $(IMAGE)

clean:
	cd $(BOOT_PATH); $(MAKE) clean
	cd $(KERNEL_PATH); $(MAKE) clean
	rm -f $(IMAGE)

export ARCH
export CC
export LD
export CFLAGS
export LDFLAGS
