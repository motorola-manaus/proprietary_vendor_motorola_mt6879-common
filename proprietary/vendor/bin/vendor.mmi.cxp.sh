#!/vendor/bin/sh

# Copyright (c) 2021, Motorola Mobility LLC, All Rights Reserved.
#
# Date Created: 8/30/2021, Set CXP properties according to carrier channel
#

set_properties()
{
	orig_sbp=$sbp
	# do not set SPB ID for M80 modem
	if [ $set_sbp_place ] && [ $set_sbp_place -ge 2 ]; then
		sbp=0
	fi
	setprop ro.vendor.mtk_md_sbp_custom_value $sbp
	setprop ro.vendor.operator.optr "$1"
	setprop ro.vendor.operator.spec "$2"
	setprop ro.vendor.operator.seg "$3"
	if [ -z "$optr" ] || [ -n "$1" ]; then
		setprop persist.vendor.mtk_usp_md_sbp_code ${orig_sbp:-$sbp}
		setprop persist.vendor.operator.optr "$1"
		setprop persist.vendor.operator.spec "$2"
		setprop persist.vendor.operator.seg "$3"
		if [ -n "$1" ]; then
			setprop persist.vendor.mtk_usp_switch_mode 1
		fi
	fi
}


boot_carrier=`getprop ro.boot.carrier`
optr=`getprop persist.vendor.operator.optr`
set_sbp_place=`getprop ro.vendor.ril.set_sbp_place`


case $boot_carrier in
	att|attpre )
		sbp=7
		set_properties OP07 SPEC0407 SEGDEFAULT
	;;
	cricket )
		sbp=145
		set_properties OP07 SPEC0407 SEGDEFAULT
	;;
	tmo|boost|cc|fi|metropcs|tracfone|retus )
		sbp=8
		set_properties OP08 SPEC0200 SEGDEFAULT
	;;
	usc )
		sbp=236
		set_properties OP236 SPEC0200 SEGDEFAULT
	;;
	vzw|vzwpre|comcast|spectrum )
		sbp=12
		set_properties OP12 SPEC0200 SEGDEFAULT
	;;
	ctcn )
		sbp=9
		setprop ro.vendor.mtk_md_sbp_custom_value 0
		set_properties OP09 SPEC0212 SEGC
	;;
	cmcc )
		sbp=1
		setprop ro.vendor.mtk_md_sbp_custom_value 1
		set_properties OP01 SPEC0200 SEGC
	;;
	retin|retjio|jioin|airin|amzin|india )
		sbp=18
		set_properties OP18 SPEC0200 SEGDEFAULT
	;;
	* )
		sim_mccmnc=`getprop persist.vendor.mtk.provision.mccmnc.0`
		[ -z "$sim_mccmnc" ] && sim_mccmnc=`getprop vendor.gsm.ril.uicc.mccmnc`
		[ -z "$sim_mccmnc" ] && sim_mccmnc=`getprop gsm.sim.operator.numeric`
		case $sim_mccmnc in
			405*|404* )
				sbp=18
				set_properties OP18 SPEC0200 SEGDEFAULT
			;;
			* )
				if [ -z "$optr" ]; then
					sbp=0
					set_properties "" "" ""
				fi
			;;
		esac
	;;
esac

return 0
