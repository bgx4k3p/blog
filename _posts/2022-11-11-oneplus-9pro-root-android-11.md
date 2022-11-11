---
title: OnePlus 9 Pro - Root Android 11
categories: android linux
tags: linux android root oneplus 9pro
---

OnePlus 9 Pro - Root Android 11

### Prerequisites:
- Running on latest Android 11 Global ROM: LE15AA_11.2.10.10
- Unlocked Bootloader


## 1. Unlock bootloader if you haven't
a. This step will erase the phone entirely

b. Enable USB Debugging again and make sure your PC is authorize

c. OEM Unlock should be grayed out (already unlocked)

## 2. Download Magisked Boot.img

OOS 11.2.10.10 boot : Untouched/Magisked (AA)

https://forum.xda-developers.com/t/guide-magisk-unlock-root-keep-root-oos-13-f-16.4252373/

## 3. Boot with temporary Root access

```bash
# Reboot in Fastboot mode
>adb reboot bootloader

# Confirm the device is showing
>fastboot devices
71xxxxb9        fastboot

# Temporary root (safer than flash directly)
>fastboot boot magisk_boot.img
Sending 'boot.img' (98304 KB)                      OKAY [  2.188s]
Booting                                            OKAY [  0.344s]
Finished. Total time: 2.609s
```

## 4. Complete Magisk install and Permanent Root

a. After booting with temporary magisk_boot.img, there will be a new app Magisk installed.

b. Open Magisk app and select **"Upgrade to full Magisk"**. It might ask to confirm installing from this source.

c. **Requires Additional Setup** - click **CANCEL**. If you clicked OK by accident, just boot in temporary root again from previous step.

d. Click Install and select **Direct Install (Recommended)**

e. Reboot


# References:
https://forum.xda-developers.com/t/guide-magisk-unlock-root-keep-root-oos-13-f-16.4252373/

https://www.droidwin.com/temporarily-root-android-via-magisk


