# balsam

balsam is Operating System and, use the Linux kernel as reference.

Kernel Image
---

```
BOOT=arch/x86/boot  
+-----------------------------------+ 0 Byte  
| $(BOOT)/loader/loader.img         |   
+-----------------------------------+ 512 Byte  
| $(BOOT)/bootsector/bootsector.img |  
+-----------------------------------+ 1024 Byte  
| $(BOOT)/header.img                |  
+-----------------------------------+ X Byte  
```


License
---
Copyright (c) 2015 Shunsuke Mie  
This software is released under the GNU General Public License v2.0.  
Please see below link.  
[gpl-2.0.txt](https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt)


