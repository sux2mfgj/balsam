CC			:= clang
LD  		:= ld

GASFLAGS    := 	-Wall -g --target=i686-elf 
CFLAGS		:= $(GASFLAGS) -I./
LDFLAGS 	:=

LDSCRIPT	:=	setup.ld
MAP 		:= kernel.map

KERNEL		:= 	kernel.img

OBJS 		:= head.o

.SUFFIXES: .S .c .o
.S.o:
	$(CC) $(CFLAGS) -c $<
.c.o:
	$(CC) $(CFLAGS) -c $<


all: $(KERNEL)

$(KERNEL): $(OBJS)
	$(LD) -T $(LDSCRIPT) $(OBJS) -o $@ --oformat binary -Map $(MAP)

clean:
	rm -f $(KERNEL) $(MAP) *.o

