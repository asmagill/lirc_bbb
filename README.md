lirc_bbb
========

This is a fork of the lirc_bbb driver which is itself a fork of the lirc_pi driver which
allows the use of a remote receiver attached to a GPIO pin of the device.  This appealed to
me because it meant I could attach a TSOP4838 (38kHz IR Receiver Module from Radio Shack)
directly to P9_14, GND, and +3.3v without any other components required.

However, all of the examples I found required building a whole brand new kernel to get this
modification to the lirc_serial driver installed... I hate rebuilding kernels for piddly
stuff, so I munged this together as a DKMS module which can be added to a running kernel.

As of now, I have only tested receiving, and under Linux 3.19.3-1-ARCH, but it works well
for me so far.

### Installation

Requires DKMS to be installed and whatever else is required for building kernel modules.

Copy the contents of this repository into /usr/src/lirc_bbb-20150411 and type
`dkms install lirc_bbb/20150411` and you should be good to go.

### From Original Source

    lirc_bbb (https://github.com/hani93/lirc_bbb)
    =============================================

    Porting RaspBerry Pi's "lirc_rpi" driver for BeagleBone Black.

    Sending is working on "P9_14" and receiving on "P9_12".

    Tested on kernel version 3.8.13 with RobertCNelson's patches.

    MrMaxx
    mrmaxx93@hotmail.com
