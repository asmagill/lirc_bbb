EXTRA_CFLAGS += $(USER_EXTRA_CFLAGS)
EXTRA_CFLAGS += -O1
#EXTRA_CFLAGS += -O3
#EXTRA_CFLAGS += -Wall
#EXTRA_CFLAGS += -Wextra
#EXTRA_CFLAGS += -Werror
#EXTRA_CFLAGS += -pedantic
#EXTRA_CFLAGS += -Wshadow -Wpointer-arith -Wcast-qual -Wstrict-prototypes -Wmissing-prototypes

EXTRA_CFLAGS += -Wno-unused-variable
EXTRA_CFLAGS += -Wno-unused-value
EXTRA_CFLAGS += -Wno-unused-label
EXTRA_CFLAGS += -Wno-unused-parameter
EXTRA_CFLAGS += -Wno-unused-function
EXTRA_CFLAGS += -Wno-unused

EXTRA_CFLAGS += -Wno-uninitialized

MACHINE=$(shell uname -m)
ifndef KERNEL_DIR
KERNEL_DIR:=/lib/modules/`uname -r`/build
endif

file_exist=$(shell test -f $(1) && echo yes || echo no)

# test for 2.6 or 2.4 kernel
ifeq ($(call file_exist,$(KERNEL_DIR)/Rules.make), yes)
PATCHLEVEL:=4
else
PATCHLEVEL:=6
endif

KERNOBJ:=lirc_bbb.o

# Name of module
ifeq ($(PATCHLEVEL),6)
MODULE:=lirc_bbb.ko
else
MODULE:=lirc_bbb.o
endif

ALL_TARGETS = $(MODULE)

all: $(ALL_TARGETS)

module: $(MODULE)

# For Kernel 2.6, we now use the "recommended" way to build kernel modules
obj-m := lirc_bbb.o
# lirc_bbb-objs := lirc_bbb.o

$(MODULE): lirc_bbb.c
	@echo "Building for Kernel Patchlevel $(PATCHLEVEL)"
	$(MAKE) modules -C $(KERNEL_DIR) M=$(CURDIR)

clean:
	rm -rf $(ALL_TARGETS) *.o *.ko Module.symvers lirc_bbb.mod.c modules.order .lirc_bbb* .tmp*

dist: clean
	cd .. ; \
	tar -cf - lirc_bbb/{Makefile,*.[ch],CHANGELOG,README} | \
	bzip2 -9 > $(HOME)/redhat/SOURCES/lirc_bbb.tar.bz2
