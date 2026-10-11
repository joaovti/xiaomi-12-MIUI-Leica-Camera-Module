# MIUI / Leica Camera for Xiaomi 12 (cupid)

[![Device](https://img.shields.io/badge/Device-Xiaomi%2012%20(cupid)-blue.svg)](#)
[![Android](https://img.shields.io/badge/Android-14%20|%2015%20|%2016%20|%2017-green.svg)](#)
[![Root](https://img.shields.io/badge/Root-KernelSU%20|%20APatch%20|%20Magisk-orange.svg)](#)
[![Architecture](https://img.shields.io/badge/Arch-ARM64--v8a%20(ARMv9)-purple.svg)](#)

A standalone Magisk / KernelSU / APatch module providing the official MIUI / Leica Camera for the Xiaomi 12 (cupid) running AOSP-based custom ROMs (LineageOS, PixelOS, crDroid, Paranoid Android, EvolutionX, etc.).

---

## Features

- Full Leica Experience: Authentic Leica color profiles, watermarks, filters, and user interface.
- Multi-Lens Switching: Ultra-Wide (0.6x), Wide (1x), and Telephoto (2x).
- Camera Modes: Photo, Video, Pro mode, Portrait, Documents, Night mode, and Slow Motion.
- Hardware Acceleration: Native DSP/NPU acceleration via Qualcomm SNPE and FastRPC Hexagon Tensor Processor (HTP v69).
- ARMv9 BTI/PAC Safe: JNI libraries patched with Branch Target Identification and Pointer Authentication landing pads to prevent SIGILL/SIGSEGV on Snapdragon 8 Gen 1.
- Multi-Android Compatibility: Complete SELinux rules tailored for Android 14 (priv_app_34), Android 15 (priv_app_35), Android 16 (priv_app_36), and Android 17 (priv_app_37).
- Clean Zygote Integration: Strictly compliant native library namespace configuration preventing 32-bit/64-bit Zygote bootloops.

---

## Requirements

- Device: Xiaomi 12 (cupid) Snapdragon 8 Gen 1 (SM8450).
- ROM: Any AOSP-based Custom ROM on Android 14, 15, 16, or 17.
- Root Solution: KernelSU, APatch, or Magisk.

> [!IMPORTANT]
> For KernelSU / APatch users:
> Due to stock GKI 5.10 kernels lacking tmpfs xattrs, you must install the Mountify metamodule with ext4_sparse mode enabled (use_ext4_sparse=1) so that /system/priv-app can be overlaid properly.

---

## Installation

1. Download the latest flashable ZIP from the Releases tab.
2. If using KernelSU or APatch:
   - Ensure the Mountify metamodule is installed and active.
3. Open your root manager (KernelSU / APatch / Magisk) and flash the ZIP.
4. Reboot your device.
5. Launch the Leica Camera app and grant all required permissions.

---

## Credits

- [Joshabys](https://github.com/Joshabys-Xiaomi-12-Org): Initial port.
- [Mountify](https://github.com/Magisk-Modules-Alt-Repo/mountify): Metamodule for loop/overlayfs mounting on GKI kernels.
