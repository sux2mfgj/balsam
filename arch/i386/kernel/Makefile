IMAGE		:= kernel.img
DEBUG_OBJ   := kernel.debug
##WIP



MM_OBJS := ../mm/distconfig.o ../mm/init.o
OBJS	:= head_32.o setup.o init_task.o $(MM_OBJS)

.S.o: 
#      $(CC) -Wall -I../include --target=i686-elf -m32 $< -c
	$(CC) $(CFLAGS) $< -c -I../include -I../../../include
.c.o:
	$(CC) $(CFLAGS) $< -c -I../include -I../../../include

all: $(OBJS) $(MM_OBJS)

$(MM_OBJS):
	cd ../mm; $(MAKE)
	
clean:
	rm -f $(OBJS)
