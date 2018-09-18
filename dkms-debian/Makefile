modname := it87
obj-m := $(modname).o

KVERSION := $(shell uname -r)
KERNEL_BUILD := /lib/modules/$(KVERSION)/build
PWD := $(shell pwd)

ifndef DRIVER_VERSION:
DRIVER_VERSION := 20181408
endif
IT87_CFLAGS=-DIT87_DRIVER_VERSION='\"$(DRIVER_VERSION)\"'

default:
	$(MAKE) EXTRA_CFLAGS="$(IT87_CFLAGS)" -C $(KERNEL_BUILD) M=$(PWD) modules

modules:
	$(MAKE) EXTRA_CFLAGS="$(IT87_CFLAGS)" -C $(KERNEL_BUILD) M=$(PWD) $@

clean:
	$(MAKE) -C $(KERNEL_BUILD) M=$(PWD) clean

install:
	$(MAKE) -C $(KERNEL_BUILD) M=$(PWD) modules_install

load:
	-/sbin/rmmod $(modname)
	/sbin/insmod $(modname).ko
