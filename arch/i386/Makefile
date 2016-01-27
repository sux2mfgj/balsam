IMAGE		:= 	balsam

BOOT		:=	boot/boot.img
KERNEL		:=	kernel/kernel.img

all: $(IMAGE)


$(IMAGE): $(BOOT) $(KERNEL)
	cat $(BOOT) $(KERNEL) > $@

$(BOOT): 
	cd boot; $(MAKE)

$(KERNEL):
	cd kernel; $(MAKE)

clean:
	cd boot; $(MAKE) clean
	cd kernel; $(MAKE) clean
	rm -f $(IMAGE)
