
QEMUFLAGS=-monitor stdio -gdb tcp::10000 #-S

LOADER=loader.img

all: $(LOADER)

$(LOADER): loader.o
	ld -T setup.ld loader.o -o $(LOADER) --oformat binary -Map bootloader.map

loader.o: loader.S
	clang --target=i686-elf -c loader.S -v -ggdb3

run: $(LOADER)
	qemu-system-i386 -fda $(LOADER) $(QEMUFLAGS)


clean:
	rm -f $(LOADER) loader.o
