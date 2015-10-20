
QEMUFLAGS	=	-monitor stdio -gdb tcp::10000 #-S

LOADER		=	loader.img
#OBJ			=	loader.o
#MAP			= 	bootloader.map

all: $(LOADER)

$(LOADER): loader.asm
	nasm loader.asm -o $@
#	ld -T setup.ld $(OBJ) -o $(LOADER) --oformat binary -Map $(MAP)

#$(OBJ): loader.S
#	clang --target=i686-elf -c loader.S -v -ggdb3

run: $(LOADER)
	qemu-system-i386 -fda $(LOADER) $(QEMUFLAGS)


clean:
	rm -f $(LOADER) $(OBJ) $(MAP)
