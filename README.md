# NixWRT

An experiment, currently, to see if Nixpkgs is a good way to build an
OS for a domestic wifi router of the kind that OpenWRT or DD-WRT or
Tomato run on.

* nixwrt.nix contains the derivation which will eventually produce a
  firmware router image
  
* everything else is a lightly forked (I hope and expect that I can
  upstream it) nixpkgs with a few changes I've had to make for
  cross-compiling some packages

## Status

* (on qemu) it builds a kernel which boots and a root filesystem that
  mounts
* but init won't start, I suspect because of missing shared libraries
  because it is not copying the closure of all the store paths

## How to run it

    nix-build nixwrt.nix -A image -o image
    nix-build nixwrt.nix -A kernel -o kernel
    
## How to run it

    nix-shell '<nixpkgs>' -p qemu --run "qemu-system-mipsel  -M malta -m 512 -kernel kernel/vmlinux  -append 'root=/dev/sr0 init=/sbin/init' -blockdev driver=file,node-name=squashed,read-only=on,filename=image/image.squashfs -blockdev driver=raw,node-name=rootfs,file=squashed,read-only=on -device ide-cd,drive=rootfs -nographic"


