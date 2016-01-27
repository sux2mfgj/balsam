LOADER		=	loader.img

all: $(LOADER)

$(LOADER): loader.asm
	nasm loader.asm -o $@

clean:
	rm -f $(LOADER) 
