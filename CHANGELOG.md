# Changelog

All notable changes to the MIUI / Leica Camera module for Xiaomi 12 (`cupid`) will be documented in this file.

---

## [v1.1] - 2026-10-14

### Added
- **Universal Standalone OverlayFS Engine**: Module now mounts itself independently at boot via `post-fs-data.sh`.
- **Zero External Dependencies**: Completely removes the requirement for the Mountify metamodule.
- **Stock & Custom GKI Kernel Support**: Intelligent auto-detection of kernel extended attribute capabilities:
  - **tmpfs mode**: Used when `CONFIG_TMPFS_XATTR=y` is available (custom kernels).
  - **ext4_sparse mode**: Automatic fallback on stock GKI 5.10 kernels, utilizing a clean loopback staging filesystem with native xattr support.
- **Automated Resource Cleanup**: Staging loopback mounts and temporary sparse images are cleanly unmounted (`umount -l`) and deleted after overlays are applied.
- **Conflict Prevention**: Built-in `skip_mount` and `skip_mountify` flags ensure no conflicting magic mounts or double mounts occur.
- **In-App Auto-Updates**: Added `updateJson` integration for KernelSU, APatch, and Magisk managers.

---

## [v1.0] - 2026-10-11

### Added
- Initial standalone port of MIUI / Leica Camera from `marble` for the Xiaomi 12 (`cupid`) on LineageOS 24 / AOSP.
- Full triple-lens switching support: Ultra-Wide (0.6x), Wide (1x), and Telephoto (2x).
- Authentic Leica color profiles (Leica Authentic / Leica Vibrant) and customizable watermarks.
- ARMv9 BTI/PAC landing pads applied to all JNI shared libraries to prevent SIGILL crashes on Snapdragon 8 Gen 1.
- Full SELinux rules covering Android 14 (`priv_app_34`), Android 15 (`priv_app_35`), Android 16 (`priv_app_36`), and Android 17 (`priv_app_37`).
- Strictly compliant native library namespace configuration without altering `/system/etc/public.libraries.txt`.
