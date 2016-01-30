
IMAGE	:= bootsector.img

all: $(IMAGE)

$(IMAGE): bootsector.asm
	nasm bootsector.asm -o $@

clean:
	rm -f $(IMAGE)
