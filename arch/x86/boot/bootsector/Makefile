
CC 			= 	clang
LD			= 	ld

CFLAGS		=	--target=i686-elf
LDFLGS		= 	--oformat binary 

BOOTSECTOR	= 	bootsector.img
OBJ			= 	bootsector.o
MAP			= 	bootsector.map
LDSCRIPT	=	setup.ld

$(BOOTSECTOR): $(OBJ)
	$(LD) -T $(LDSCRIPT) $(OBJ) -o $(BOOTSECTOR) $(LDFLGS) -Map $(MAP)

$(OBJ): bootsector.S
	$(CC) $(CFLAGS) -c bootsector.S

clean:
	rm -f $(BOOTSECTOR) $(OBJ) $(MAP)

