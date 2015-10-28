IMAGE		:= kernel.img

ARCHPATH	:= ../arch/$(ARCH)
ARCHOBJS	:= $(ARCHPATH)/kernel/head.o
OBJS		:= $(ARCHOBJS) main.o

LDSCRIPT 	:= kernel.ld
MAP			:= kernel.map

all: $(IMAGE)

$(IMAGE): $(OBJS) $(LDSCRIPT)
	$(LD) $(LDFLAGS) $(OBJS) -o $@ -T $(LDSCRIPT) 

.c.o: 
	$(CC) $(CFLAGS) $< -c

$(ARCHOBJS):
	cd $(ARCHPATH)/kernel; $(MAKE)

$(LDSCRIPT): $(LDSCRIPT).S
	$(CC) -P -E $< -o kernel.ld

clean:
	cd $(ARCHPATH)/kernel; $(MAKE) clean
	rm -f $(IMAGE) $(OBJS) $(MAP) $(LDSCRIPT)
