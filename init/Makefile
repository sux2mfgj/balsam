IMAGE		:= kernel.img
DEBUG_OBJ   := kernel.debug

ARCHPATH	:= ../arch/$(ARCH)
ARCHOBJS	:= $(ARCHPATH)/kernel/head_32.o $(ARCHPATH)/kernel/setup.o $(ARCHPATH)/kernel/init_task.o

MMPATH		:= ../mm
MMOBJS		:= $(MMPATH)/bootmem.o

OBJS		:= $(ARCHOBJS) main.o $(MMOBJS)


LDSCRIPT 	:= kernel.ld
MAP			:= kernel.map

all: $(IMAGE) $(DEBUG_OBJ)

$(IMAGE): $(OBJS) $(ARCHOBJS) $(LDSCRIPT)
	$(LD) $(LDFLAGS) $(OBJS) -o $@ -T $(LDSCRIPT) 

$(MMOBJS): 
	cd $(MMPATH); $(MAKE)

$(DEBUG_OBJ): $(OBJS) $(ARCHOBJS) $(LDSCRIPT)
	$(LD) $(DEBUG_LDFLAGS) $(OBJS) -o $@ -T $(LDSCRIPT)

.c.o: 
	$(CC) $(CFLAGS) -I ../include $< -c

$(ARCHOBJS):
	cd $(ARCHPATH)/kernel; $(MAKE)

$(LDSCRIPT): $(LDSCRIPT).S
	$(CC) -P -E $< -o kernel.ld -I../include

clean:
	cd $(ARCHPATH)/kernel; $(MAKE) clean
	rm -f $(IMAGE) $(OBJS) $(MAP) $(LDSCRIPT)
