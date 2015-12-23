KERNEL = kernel.img
OBJS	:= head.o main.o

.S.o: 
	$(CC) -Wall -I../include --target=i686-elf -m32 $< -c

all: $(KERNEL)

$(KERNEL): $(OBJS)
	

	
clean:
	rm -f $(OBJS)
