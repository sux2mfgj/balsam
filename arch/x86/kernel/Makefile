KERNEL = kernel.img

LDSCRIPT := kernel.ld

OBJS	:= head.o 

.S.o: 
#      $(CC) -Wall -I../include --target=i686-elf -m32 $< -c
	$(CC) $(CFLAGS) $< -c -I../include

all: $(OBJS)

#  $(KERNEL): $(OBJS)
#      $(LD) $(LDFLAGS) -T $(LDSCRIPT) $(OBJS)
	
clean:
	rm -f $(OBJS)
