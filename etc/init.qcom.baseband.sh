#!/sbin/sh

# Variables
MSM_PARTITION=/dev/block/mmcblk0p1
INFO_PARTITION=/dev/block/mmcblk0p10
RAWDATA_PARTITION=/dev/block/mmcblk0p11

# get file descriptor for output
OUTFD=$(ps | grep -v "grep" | grep -o -E "update_binary(.*)" | cut -d " " -f 3);

# same as progress command in updater-script, for example:
#
# progress 0.25 10
#
# will update the next 25% of the progress bar over a period of 10 seconds

progress() {
  if [ $OUTFD != "" ]; then
    echo "progress ${1} ${2} " 1>&$OUTFD;
  fi;
}

# same as set_progress command in updater-script, for example:
#
# set_progress 0.25
#
# sets progress bar to 25%

set_progress() {
  if [ $OUTFD != "" ]; then
    echo "set_progress ${1} " 1>&$OUTFD;
  fi;
}

# same as ui_print command in updater_script, for example:
#
# ui_print "hello world!"
#
# will output "hello world!" to recovery, while
#
# ui_print
#
# outputs an empty line

ui_print() {
  if [ $OUTFD != "" ]; then
    echo "ui_print ${1} " 1>&$OUTFD;
    echo "ui_print " 1>&$OUTFD;
  else
    echo "${1}";
  fi;
}


# echo goes to recovery.log, ui_print goes to screen and recovery.log
echo "init.qcom.baseband.sh starting with arguments: $@"

ui_print "Get your baseband version..."

board_info=`dd if=$INFO_PARTITION | strings | grep -- "IM-" | head -n 1`

if [ "$board_info" == "" ];then
	ui_print "ERROR: Could not get your mobile phone version!"
	exit 1
else
	sw_info=`dd if=$INFO_PARTITION | strings | grep "S[0-9]" | head -n 1`
	msm_info=`dd if=$MSM_PARTITION bs=128000 count=150 skip=8 | strings | grep -- "M8974A-" | head -n 1`

	imei_info=`dd if=$RAWDATA_PARTITION bs=1 count=8 skip=113825 | hexdump -C | sed -n '1p'| sed 's/00000000 //' | sed 's/ *//g' | cut -c1-16 | sed -r 's/(.)(.)/\2\1/g' | cut -c2-16`

	wifi_mac_info=`dd if=$RAWDATA_PARTITION bs=1 count=6 skip=222724 | hexdump -C | sed -n '1p'| sed 's/00000000 //' | sed 's/ *//g' | cut -c1-12`

	bt_mac_info=`dd if=$RAWDATA_PARTITION bs=1 count=6 skip=223236 | hexdump -C | sed -n '1p' | sed 's/00000000 //' | sed 's/ *//g'| cut -c1-12 | sed -r 's/(..)(..)(..)(..)(..)(..)/\6\5\4\3\2\1/g'`

	#echo $'\n'$msm$'\n' > /persist/.baseband
	#BB_VER=`cat /persist/.baseband`
	ui_print "Your phone version:"
	ui_print "Board: "$board_info
	ui_print "SW: "$sw_info
	ui_print "IMEI: "$imei_info
	ui_print "WIFI_MAC: "$wifi_mac_info
	ui_print "BT_MAC: "$bt_mac_info
	ui_print "BB: "$msm_info
fi

model="ro.product.model="$board_info
name="ro.product.name="$board_info
cp /system/build.prop /tmp/build.prop

sed -i '/^ro.product.name=*/c\'"$name"'' /tmp/build.prop
sed -i '/^ro.product.model=*/c\'"$model"'' /tmp/build.prop

cp /tmp/build.prop /system/build.prop



