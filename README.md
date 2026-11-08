# AERA Recovery device tree — Xiaomi Beryl

Device tree for the **Redmi Note 14 5G / POCO M7 Pro 5G** (codename `beryl`), adapted from the existing working OrangeFox/TWRP tree for **AERA Recovery 16.0**.

> **Port status: initial AERA adaptation — not yet validated by a successful AERA build and on-device test.**
>
> The previous OrangeFox tree was working. This port intentionally keeps the Beryl-specific kernel, DTB, vendor ramdisk, fstab, init scripts, partition layout, encryption services and vendor-module list unchanged. A successful build is not proof that boot, decryption or flashing is safe; test before daily use.

## Device specifications

| Feature | Specification |
|---|---|
| Chipset | MediaTek Dimensity 7025-Ultra (MT6855) |
| CPU | Octa-core: 2× Cortex-A78 + 6× Cortex-A55 |
| GPU | IMG BXM-8-256 |
| Memory | 6 GB / 8 GB RAM |
| Shipped OS | Android 14 (HyperOS) |
| Storage | 128 GB / 256 GB |
| Display | 6.67-inch AMOLED, 120 Hz, 1080 × 2400 |
| Battery | 5110 mAh |
| Recovery layout | Recovery ramdisk in `vendor_boot`, boot header v4 |
| Dynamic partitions | Virtual A/B |

## Repository layout

- `BoardConfig.mk` — hardware, boot image, partition, crypto and AERA build flags.
- `device.mk` — Beryl-specific packages, vendor ramdisk files and recovery dependencies.
- `aera_beryl.mk` — AERA UI and device-specific recovery behavior.
- `twrp_beryl.mk` — product definition retained with AERA's `twrp_` product naming convention.
- `vendorsetup.sh` — AERA build environment options.
- `recovery/root/` and `vendor_ramdisk/` — device-specific recovery/init resources.

## Build

### GitHub Actions

This repository includes a manual GitHub Actions workflow:

`.github/workflows/AERA-Build.yml`

1. Open the repository's **Actions** tab.
2. Select **AERA Recovery - Beryl Build**.
3. Select **Run workflow** on branch `fox_14.1`.
4. Keep the default device-tree branch and `vendorbootimage` target for the Beryl vendor_boot recovery layout.
5. Download the generated artifact from the completed workflow run.

The workflow syncs the official AERA manifest branch `aera-16.0`, clones this device tree, exports `AERA_BUILD_DEVICE=beryl` before sourcing the build environment, and builds the selected image. Artifacts are retained by GitHub Actions for 14 days. The workflow does not publish a flashable release automatically.

### Manual build

Use the AERA 16.0 source tree and manifest:

```bash
repo init -u https://github.com/AERA-Recovery/android_manifest.git -b aera-16.0
repo sync -c --force-sync --no-clone-bundle --no-tags -j$(nproc)
git clone -b fox_14.1 https://github.com/sairajkandkar007/device_xiaomi_beryl_recovery.git device/xiaomi/beryl

export AERA_BUILD_DEVICE=beryl
source build/envsetup.sh
lunch twrp_beryl-bp2a-eng
mka adbd vendorbootimage
```

The output directory is `out/target/product/beryl/`. Check the build log and confirm the generated image's boot header, ramdisk placement and size before testing. Do not assume that an image produced for another device or an old build artifact is suitable.

## Initial validation checklist

Before considering the port usable, test on the exact supported firmware and keep a known-good restore path.

- [ ] AERA image boots from the correct `vendor_boot` recovery path.
- [ ] Display, touch, brightness and USB ADB work.
- [ ] Internal storage mounts and decrypts with a PIN/pattern.
- [ ] Boot without a screen lock reaches recovery normally.
- [ ] Metadata and userdata mount/format behavior is verified on a safe test setup.
- [ ] MTP, sideload and fastbootd are tested independently.
- [ ] Vendor modules load at the correct stage.
- [ ] Backup/restore and non-destructive ZIP installation are verified.
- [ ] Reboot to system, recovery and bootloader works.

**Encryption note:** the tree carries forward the existing MediaTek KeyMint/Keymaster, Gatekeeper and prepdecrypt integration. AERA's crypto flags do not independently guarantee decryption. Validate service ordering and successful unlock on the intended ROM before relying on it.

**SELinux note:** the inherited device configuration currently sets recovery SELinux permissive for debugging. This is not an enforcing configuration and should be revisited only with complete policy and boot-log validation.

## Flashing precautions

Do not flash this initial AERA port over your only working recovery. First build it, inspect the resulting image, and test it using a device-appropriate temporary boot or a verified restore procedure. Beryl uses recovery in `vendor_boot`; do not treat it as a conventional standalone recovery-partition device. Never flash a generic recovery image to `boot`, `vendor_boot`, or `super` without verifying the exact image and target.

## Credits

- **IQ_HARRY_07** — Beryl device tree maintenance and testing.
- **Khargosxh18** — Device tree rebasing and adaptation.
- **Darthjabba9** — Technical mentorship and project support.
- **Azzychy** — Assistance and troubleshooting.
- **Specko** — Base tree contributions and technical direction.
- **Eyad** — Project support and troubleshooting.
- **!Cloud** — Base tree contributions and pull requests.
- **KoaaN** — Decryption support and V36 prebuilt assistance.
- **Sharp shooter** — Device tree refinements.
- **egaschnsk** — `vendor_boot` implementation references.
- **Aditya Prasad** — Project assistance.
- **All testers and contributors** — Testing, feedback and support.

AERA Recovery project: https://aera-recovery.com/
