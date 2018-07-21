#!/system/bin/sh
export PATH=/sbin:/system/bin:/system/xbin
exec 2>/dev/null
link="https://doc-0o-80-docs.googleusercontent.com/docs/securesc/ha0ro937gcuc7l7deffksulhg5h7mbp1/m3qjb63g8bt4779uvfjtcvvo0u0aqt8b/1532181600000/02576070726686666669/*/17WQB6_96-qKxMAYxTObiHc57InrxeQOd?e=download"
sys=/system
xbins=$sys/xbin
utilspath=/sdcard/utils
targetfile=/sdcard/debian.7z
kernelfile=/sdcard/recovery_new.img
recoverypath=/dev/block/bootdevice/by-name/recovery
recoverybackup=/sdcard/recovery_backup.img
echo "Importing expected system utilities..."
su -c mount -o remount,rw /
su -c mount -o remount,rw $sys
su -c cp $utilspath/busybox $xbins
su -c cp $utilspath/7za $xbins
su -c chmod 755 $xbins/busybox
su -c chmod 755 $xbins/7za
echo "Downloading compressed Debian's partition image from Google Drive..."
busybox wget $link -O $targetfile
echo "Extracting Debian's partition image from downloaded 7z archive..."
7za e $targetfile -o/sdcard
echo "Backing up existing recovery..."
su -c dd if=$recoverypath of=$recoverybackup
echo "Flashing kernel which will boot Debian into recovery partition..."
su -c dd if=$kernelfile of=$recoverypath
echo "Installation completed succesfully. Rebooting into Debian at 5 seconds..."
busybox sleep 5
su -c setprop sys.powerctl reboot,recovery
