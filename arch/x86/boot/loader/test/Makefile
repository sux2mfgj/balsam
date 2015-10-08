TEST=test.img

all: $(TEST)

$(TEST): test.S test.ld
	clang --target=i686-elf -c test.S -v -ggdb3
	ld -T test.ld test.o -o test.img --oformat binary 

clean:
	rm -f $(TEST)
