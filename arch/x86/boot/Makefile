BOOT 		= 	boot.img

LOADER 		:= 	loader/loader.img
BOOTSECTOR 	:= 	bootsector/bootsector.img

HEADER		:=	header.img

QEMUFLAGS	:=	-monitor stdio -gdb tcp::10000 #-S

all: $(BOOT)

$(BOOT): $(LOADER) $(BOOTSECTOR) $(HEADER)
	cat $(LOADER) $(BOOTSECTOR) $(HEADER) > $@

$(HEADER):
	nasm header.asm -o header.img

$(LOADER):
	cd loader; $(MAKE)

$(BOOTSECTOR):
	cd bootsector; $(MAKE)

run: $(BOOT)
	qemu-system-i386 -fda $(BOOT) $(QEMUFLAGS)

clean:
	cd loader; $(MAKE) clean
	cd bootsector; $(MAKE) clean
	rm -f $(HEADER) $(BOOT)
