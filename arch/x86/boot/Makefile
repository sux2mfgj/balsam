CC			:= clang

QEMUFLAGS	:=	-monitor stdio -gdb tcp::10000 #-S
GASFLAGS    := 	-Wall -g --target=i686-elf
CFLAGS		:= $(GASFLAGS) -I./ -I../include

BOOT 		:= 	boot.img

LOADER 		:= 	loader/loader.img
BOOTSECTOR 	:= 	bootsector/bootsector.img

HEADER		:=	header.img
OBJS		:= 	header.o main.o protected_mode_jump.o load.o
MAP			:= 	header.map
LDSCRIPT	:=	setup.ld

.SUFFIXES: .S .c .o
.S.o:
	$(CC) $(CFLAGS) -c $<
.c.o:
	$(CC) $(CFLAGS) -c $<

all: $(BOOT)

$(BOOT): $(BOOTSECTOR) $(LOADER) $(HEADER)
	$(MAKE) $(HEADER)
	cat $(LOADER) $(BOOTSECTOR) $(HEADER) > $(BOOT)

$(LOADER): 
	cd loader; $(MAKE)

$(BOOTSECTOR):
	cd bootsector; $(MAKE)

$(HEADER): $(OBJS) $(LDSCRIPT)
	ld -T $(LDSCRIPT) $(OBJS) -o $(HEADER) --oformat binary -Map $(MAP)

run: $(BOOT)
	qemu-system-i386 -fda $(BOOT) $(QEMUFLAGS)

clean:
	cd loader; $(MAKE) clean
	cd bootsector; $(MAKE) clean
	rm -f $(HEADER) $(OBJS) $(MAP) $(BOOT)

