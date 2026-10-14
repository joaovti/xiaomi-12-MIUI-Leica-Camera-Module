# MIUI / Leica Camera for Xiaomi 12 (cupid)

[![Device](https://img.shields.io/badge/Device-Xiaomi%2012%20(cupid)-blue.svg)](#)
[![Android](https://img.shields.io/badge/Android-14%20|%2015%20|%2016%20|%2017-green.svg)](#)
[![Root](https://img.shields.io/badge/Root-KernelSU%20|%20APatch%20|%20Magisk-orange.svg)](#)
[![Architecture](https://img.shields.io/badge/Arch-ARM64--v8a%20(ARMv9)-purple.svg)](#)
[![Version](https://img.shields.io/badge/Version-v1.1-brightgreen.svg)](https://github.com/joaovti/Xiaomi-12-MIUI-Leica-Camera-Module/releases)

A standalone Magisk / KernelSU / APatch module providing the official MIUI / Leica Camera for the Xiaomi 12 (cupid) running AOSP-based custom ROMs (LineageOS, PixelOS, crDroid, Paranoid Android, EvolutionX, etc.).

---

## Features

- **Universal Auto-Mounting (Zero Dependencies)**: Built-in standalone OverlayFS engine that auto-detects kernel capabilities. Operates in fast `tmpfs` mode if `CONFIG_TMPFS_XATTR` is present, or automatically falls back to an internal loopback `ext4_sparse` staging mount on stock GKI kernels. **No Mountify metamodule required!**
- **Full Leica Experience**: Authentic Leica color profiles, watermarks, filters, and user interface.
- **Multi-Lens Switching**: Ultra-Wide (0.6x), Wide (1x), and Telephoto (2x).
- **Camera Modes**: Photo, Video, Pro mode, Portrait, Documents, Night mode, and Slow Motion.
- **Hardware Acceleration**: Native DSP/NPU acceleration via Qualcomm SNPE and FastRPC Hexagon Tensor Processor (HTP v69).
- **ARMv9 BTI/PAC Safe**: JNI libraries patched with Branch Target Identification and Pointer Authentication landing pads to prevent SIGILL/SIGSEGV on Snapdragon 8 Gen 1.
- **Multi-Android Compatibility**: Complete SELinux rules tailored for Android 14 (`priv_app_34`), Android 15 (`priv_app_35`), Android 16 (`priv_app_36`), and Android 17 (`priv_app_37`).
- **Clean Zygote Integration**: Strictly compliant native library namespace configuration preventing 32-bit/64-bit Zygote bootloops.
- **Automated In-App Updates**: Integrated `updateJson` supporting automatic updates directly inside KernelSU, APatch, and Magisk managers.

---

## Requirements

- **Device**: Xiaomi 12 (cupid) Snapdragon 8 Gen 1 (SM8450).
- **ROM**: Any AOSP-based Custom ROM on Android 14, 15, 16, or 17.
- **Root Solution**: KernelSU, APatch, or Magisk.
- **Kernel**: Stock GKI 5.10 or Custom Kernels (both fully supported out-of-the-box).

---

## Installation

1. Download the latest flashable ZIP from the [Releases](https://github.com/joaovti/Xiaomi-12-MIUI-Leica-Camera-Module/releases) tab (`Xiaomi-12-MIUI-Leica-Camera-v1.1.zip`).
2. Flash the ZIP in your root manager (KernelSU / APatch / Magisk).
3. Reboot your device.
4. Launch the Leica Camera app and grant all required permissions.

---

## Changelog

See the full history of changes in [CHANGELOG.md](CHANGELOG.md).

---

## Credits

- [Joshabys](https://github.com/Joshabys-Xiaomi-12-Org): Initial port.
- [backslashxx/mountify](https://github.com/backslashxx/mountify): Base OverlayFS mounting logic.
