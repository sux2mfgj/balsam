
QEMUFLAGS	=	-monitor stdio -gdb tcp::10000 #-S

LOADER		=	loader.img
#OBJ			=	loader.o
#MAP			= 	bootloader.map

all: $(LOADER)
	$(MAKE) $(LOADER)
	cd test; $(MAKE) 

$(LOADER): loader.asm
	nasm loader.asm -o $@
#	ld -T setup.ld $(OBJ) -o $(LOADER) --oformat binary -Map $(MAP)

#$(OBJ): loader.S
#	clang --target=i686-elf -c loader.S -v -ggdb3

run: $(LOADER)
	cd test; $(MAKE)
	cat $(LOADER) test/test.img > test.img
	qemu-system-i386 -fda test.img $(QEMUFLAGS)

clean:
	rm -f $(LOADER) $(OBJ) $(MAP) test.img
	cd test; $(MAKE) clean
