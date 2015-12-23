
OBJS	:= head.o

.S.o: 
	$(CC) -Wall -I../include --target=i686-elf -m32 $< -c

all: $(OBJS)
	
clean:
	rm -f $(OBJS)
