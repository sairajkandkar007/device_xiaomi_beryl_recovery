#!/bin/bash
#
# AERA Recovery build setup for Xiaomi Beryl
# SPDX-License-Identifier: GPL-3.0-only
#

FDEVICE="beryl"

# AERA_BUILD_DEVICE must be exported by the build environment before
# sourcing build/envsetup.sh, as documented by AERA.
if [ "${AERA_BUILD_DEVICE}" = "${FDEVICE}" ]; then
    export LC_ALL="C"
    export ALLOW_MISSING_DEPENDENCIES=true

    # Device partition layout
    export AERA_VIRTUAL_AB_DEVICE=1
    export AERA_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
    export AERA_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"

    # AERA build tools
    export AERA_USE_BASH_SHELL=1
    export AERA_USE_BUSYBOX_BINARY=1
    export AERA_USE_TAR_BINARY=1
    export AERA_USE_SED_BINARY=1
    export AERA_USE_XZ_UTILS=1
    export AERA_USE_ZSTD_BINARY=1
    export AERA_USE_LZ4_BINARY=1
    export AERA_USE_GREP_BINARY=1

    # Device build metadata
    export AERA_BUILD_STATUS=Unofficial
    export AERA_BUILD_TYPE=Beta
else
    echo "I: vendorsetup.sh skipped; set AERA_BUILD_DEVICE=beryl before sourcing envsetup.sh."
fi
