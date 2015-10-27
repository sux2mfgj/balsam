IMAGE		:= kernel.img

ARCHPATH	:= ../arch/$(ARCH)
ARCHOBJS	:= $(ARCHPATH)/kernel/head.o
OBJS		:= $(ARCHOBJS) main.o

LDSCRIPT 	:= kernel.ld
MAP			:= kernel.map

all: $(IMAGE)

$(IMAGE): $(OBJS)
	$(LD) $(LDFLAGS) $(OBJS) -o $@ -T $(LDSCRIPT) -Map $(MAP)

.c.o: 
	$(CC) $(CFLAGS) $< -c

$(ARCHOBJS):
	cd $(ARCHPATH)/kernel; $(MAKE)

clean:
	cd $(ARCHPATH)/kernel; $(MAKE) clean
	rm -f $(IMAGE) $(OBJS) $(MAP)
