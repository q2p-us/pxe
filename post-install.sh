#!/bin/bash
set -x
readonly LOG_FILE="/root/post-install.log"
touch $LOG_FILE
exec 1>$LOG_FILE
exec 2>&1

echo "##### Start post install actions ..."

echo "### Start configure of serial-getty ..."
systemctl enable serial-getty@ttyS0.service
systemctl start serial-getty@ttyS0.service
echo "### Finish configure of serial-getty."

echo "### Start configure of serial access on GRUB ..."
sed -i -r 's/^(GRUB_CMDLINE_LINUX_DEFAULT)/#\1/' /etc/default/grub
sed -i -r 's/^(GRUB_CMDLINE_LINUX=).*/\1"console=tty0 console=ttyS0,115200n8"/' /etc/default/grub
sed -i -r 's/^#?(GRUB_TERMINAL=).*/\1"console serial"/' /etc/default/grub
egrep -q "^GRUB_SERIAL_COMMAND=" /etc/default/grub && sed -i -r 's/^(GRUB_SERIAL_COMMAND=).*/\1"serial --speed=115200 --unit=0 --word=8 --parity=no --stop=1"/' /etc/default/grub || echo 'GRUB_SERIAL_COMMAND="serial --speed=115200 --unit=0 --word=8 --parity=no --stop=1"' >> /etc/default/grub
update-grub
echo "### Finish configure of serial access on GRUB."

echo "##### Finish post install actions."
