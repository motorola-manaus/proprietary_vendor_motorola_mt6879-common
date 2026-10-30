# Motorola MT6879 Common Vendor Tree

This repository provides proprietary blobs and prebuilts shared across Motorola devices powered by the **MediaTek Dimensity 7030 (MT6879)** SoC.

## Contents

* **Audio & Codecs:** MediaTek audio HALs, soundfx plugins, and 64-bit Savitech LHDC encoders (`liblhdc.so`, `liblhdcBT_enc.so`, `liblhdcv5.so`, `liblhdcv5BT_enc.so`).
* **Display & Graphics:** MediaTek Picture Quality (`vendor.mediatek.hardware.pq`), HWComposer, and GPU drivers.
* **Camera:** Common ISP, camera provider HAL, and tuning algorithms.
* **Connectivity:** Bluetooth audio HAL, WiFi HAL, and GPS/GNSS (`mnld`).
* **Telephony & IMS:** Video Telephony, IMS services (`ImsService.apk`, `MtkGbaService.apk`), and RIL libraries.

## Directory Path in Source Tree

```bash
vendor/motorola/mt6879-common
```

## How to Clone

```bash
git clone https://github.com/motorola-manaus/proprietary_vendor_motorola_mt6879-common.git -b seventeen vendor/motorola/mt6879-common
```

## License

* Proprietary binaries extracted from official Motorola firmware release `V1TMS35H.3-45-3-2-7`.
