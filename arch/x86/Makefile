BOOT		:=	boot/boot.img
#  KERNEL		:=	kernel/kernel.img
#  BALSAM		:= 	balsam

#  all: $(BALSAM)
all: $(BOOT)


#  $(BALSAM): $(BOOT) $(KERNEL)
#      cat $(BOOT) $(KERNEL) > $@

$(BOOT): 
	cd boot; $(MAKE)

#  $(KERNEL):
#      cd kernel; $(MAKE)

clean:
	cd boot; $(MAKE) clean
#      cd kernel; $(MAKE) clean
#      rm -f $(BALSAM)

#  export ARCH
#  export CC
#  export LD
#  export CFLAGS
#  export LDFLAGS
