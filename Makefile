ARCH 	:= 	x86

IMG		:=	balsam

BOOT_PATH	:= arch/$(ARCH)/boot
BOOT	:= 	$(BOOT_PATH)/boot.img

KERNEL_PATH	:= arch/$(ARCH)/kernel
KERNEL	:= 	$(KERNEL_PATH)/kernel.img

QEMU    	:=	qemu-system-i386
QEMUFLAGS	:=	-monitor stdio -gdb tcp::10000 -m 128 #-S


all: $(IMG)

$(IMG): $(BOOT) $(KERNEL)
	cat $(BOOT) $(KERNLE) > $@

$(BOOT) $(KERNEL):
	cd arch/$(ARCH); $(MAKE)

run: $(IMG)
	$(QEMU) -fda $(IMG) $(QEMUFLAGS)


clean:
	cd arch/$(ARCH); $(MAKE) clean
	rm -f $(IMG)
