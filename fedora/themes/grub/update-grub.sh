#!/bin/bash

GRUB_CFG=/boot/efi/EFI/fedora/grub.cfg
grub2-mkconfig -o ${GRUB_CFG}
