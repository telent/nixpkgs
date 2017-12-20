# NixWRT

An experiment, currently, to see if Nixpkgs is a good way to build an
OS for a domestic wifi router of the kind that OpenWRT or DD-WRT or
Tomato run on.

* nixwrt.nix contains the derivation which will eventually produce a
  firmware router image
  
* everything else is a lightly forked (I hope and expect that I can
  upstream it) nixpkgs with a few changes I've had to make for
  cross-compiling some packages

## Status/TODO

- [x] builds a kernel
- [x] builds a root filesystem
- [x] statically linked init (busybox) runs
- [ ] make shared libraries work

Currently: There is a problem with squashfs or the way we are using it
which means that `/nix/store` is empty when the squashfs image is
mounted (the `-root-becomes` option doesn't appear to work).  This is
an obvious cause of shared libraries not working - because they're not
there.  Probably what we should do instead is build an initramfs and
then mount the squashfs onto `/nix/store` in the initramfs "/init" script.

What needs to go in the root fs
/bin/sh
/init  - mount /dev /sys /proc /nix/store
/etc - where should we get this?

now having second thoughts that this needs to be a ramdisk anyway
... if the root fs comes from the same mmc as the kernel, might as
well make it a filesystem image
## How to run it

    nix-build nixwrt.nix -A image -o image
    nix-build nixwrt.nix -A kernel -o kernel
    
## How to run it

    nix-shell '<nixpkgs>' -p qemu --run "qemu-system-mipsel  -M malta -m 512 -kernel kernel/vmlinux  -append 'root=/dev/sr0 console=ttyS0 init=/bin/sh' -blockdev driver=file,node-name=squashed,read-only=on,filename=image/image.squashfs -blockdev driver=raw,node-name=rootfs,file=squashed,read-only=on -device ide-cd,drive=rootfs -nographic"


