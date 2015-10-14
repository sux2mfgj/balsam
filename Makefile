ARCH 	:= 	x86

IMG		:=	balsam

BOOT_PATH	:= arch/$(ARCH)/boot
BOOT	:= 	$(BOOT_PATH)/boot.img

KERNEL_PATH	:= arch/$(ARCH)/kernel
KERNEL	:= 	$(KERNEL_PATH)/kernel.img


all: $(IMG)

$(IMG): $(BOOT) $(KERNEL)
	cat $(BOOT) $(KERNLE) > $@

$(BOOT) $(KERNEL):
	cd arch/$(ARCH); $(MAKE)

clean:
	cd arch/$(ARCH); $(MAKE) clean
	rm -f $(IMG)
