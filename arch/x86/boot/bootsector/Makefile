
BOOTSECTOR	:=	bootsector.img 

all: $(BOOTSECTOR)


$(BOOTSECTOR): bootsector.asm
	nasm bootsector.asm -o $@

clean:
	rm -f $(BOOTSECTOR)
