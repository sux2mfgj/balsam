CC			:=	clang
LD  		:= 	ld

GASFLAGS    := 	-Wall -g --target=i686-elf 
CFLAGS		:= 	$(GASFLAGS) -I./ -I../include/
LDFLAGS 	:=

LDSCRIPT	:=	kernel.ld
MAP 		:= 	kernel.map

KERNEL		:= 	kernel.img

ARCH_OBJS 	:= 	main.o util.o
OBJS 		:= 	#../../../kernel/

.SUFFIXES: .S .c .o
.S.o:
	$(CC) $(CFLAGS) -c $<
.c.o:
	$(CC) $(CFLAGS) -c $<

all: $(KERNEL)

$(KERNEL): $(ARCH_OBJS) $(OBJS)
	$(LD) -T $(LDSCRIPT) $(ARCH_OBJS) $(OBJS) -o $@ --oformat binary -Map $(MAP)

$(OBJS):
	cd ../../../kernel; $(MAKE)

clean:
	cd ../../../kernel; $(MAKE) clean
	rm -f $(KERNEL) $(MAP) *.o

