#
# Copyright (C) 2026 The Android Open Source Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/beryl

# Inherit base product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(DEVICE_PATH)/device.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Device-specific AERA Recovery configuration
$(call inherit-product, $(DEVICE_PATH)/aera_beryl.mk)

PRODUCT_RELEASE_NAME := beryl
PRODUCT_DEVICE := beryl
PRODUCT_NAME := twrp_beryl
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := Redmi Note 14 5G
PRODUCT_MANUFACTURER := Xiaomi

TARGET_OTA_ASSERT_DEVICE := beryl

# Device properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.twrp.vendor_boot=true \
    persist.sys.fuse.passthrough.enable=true
