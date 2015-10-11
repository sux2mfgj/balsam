BOOT	:=	boot/boot.img
KERNEL	:=	kernel/kernel.img
BALSAM	:= 	balsam.img

all: $(BALSAM)

$(BALSAM): $(BOOT) $(KERNEL)
#      cd boot; $(MAKE)
#      cd kernel; $(MAKE)
	cat $(BOOT) $(KERNEL) > $@

$(BOOT): 
	cd boot; $(MAKE)

$(KERNEL):
	cd kernel; $(MAKE)


clean:
	cd boot; $(MAKE) clean
	cd kernel; $(MAKE) clean
	rm -f $(BALSAM)
