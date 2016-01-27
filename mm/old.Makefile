
OBJS 	:= 	bootmem.o memory.o page_alloc.o

.c.o:
	$(CC) $(CFLAGS) $< -c -I../include

all: $(OBJS)

clean:
	rm -f $(OBJS)


