OBJS	:= init.o distconfig.o

.S.o: 
	$(CC) $(CFLAGS) $< -c -I../include -I../../../include
.c.o:
	$(CC) $(CFLAGS) $< -c -I../include -I../../../include

all: $(OBJS)
	
clean:
	rm -f $(OBJS)
