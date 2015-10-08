CC		= clang

QEMUFLAGS	=	-monitor stdio -gdb tcp::10000 #-S

BOOT 	= 	boot.img

LOADER 	= 	loader/loader.img

HEADER	=	header.img
OBJ		= 	header.o
MAP		= 	header.map
LDSCRIPT=	setup.ld

all:
	cd loader; $(MAKE)
	$(MAKE) $(HEADER)
	cat $(LOADER) $(HEADER) > $(BOOT)

$(HEADER): $(OBJ) $(LDSCRIPT)
	ld -T $(LDSCRIPT) $(OBJ) -o $(HEADER) --oformat binary -Map $(MAP)

$(OBJ): header.S
	clang --target=i686-elf -c header.S -ggdb3

run: $(BOOT)
	qemu-system-i386 -fda $(BOOT) $(QEMUFLAGS)


clean:
	cd loader; $(MAKE) clean
	rm -f $(HEADER) $(OBJ) $(MAP)
	

