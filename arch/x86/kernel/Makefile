#MM_OBJS := ../mm/distconfig.o
OBJS	:= head_32.o setup.o $(MM_OBJS)

.S.o: 
#      $(CC) -Wall -I../include --target=i686-elf -m32 $< -c
	$(CC) $(CFLAGS) $< -c -I../include -I../../../include

all: $(OBJS)
	
clean:
	rm -f $(OBJS)
