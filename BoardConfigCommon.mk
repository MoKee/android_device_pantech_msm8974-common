#
# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

TARGET_SPECIFIC_HEADER_PATH := device/pantech/msm8974-common/include

BOARD_VENDOR 						:= pantech

TARGET_CPU_ABI 						:= armeabi-v7a
TARGET_CPU_ABI2 					:= armeabi
TARGET_CPU_SMP 						:= true
TARGET_ARCH 						:= arm
TARGET_ARCH_VARIANT 				:= armv7-a-neon
ARCH_ARM_HAVE_ARMV7A 				:= true
TARGET_CPU_VARIANT 					:= krait
ARCH_ARM_HAVE_NEON 					:= true
ARCH_ARM_HAVE_TLS_REGISTER 			:= true

# Flags
TARGET_GLOBAL_CFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mfpu=neon -mfloat-abi=softfp

# Krait optimizations
TARGET_USE_KRAIT_BIONIC_OPTIMIZATION:= true
TARGET_USE_KRAIT_PLD_SET 			:= true
TARGET_KRAIT_BIONIC_PLDOFFS 		:= 10
TARGET_KRAIT_BIONIC_PLDTHRESH 		:= 10
TARGET_KRAIT_BIONIC_BBTHRESH 		:= 64
TARGET_KRAIT_BIONIC_PLDSIZE 		:= 64

TARGET_NO_BOOTLOADER 				:= true

TARGET_NO_RADIOIMAGE 				:= true
TARGET_BOARD_PLATFORM 				:= msm8974
TARGET_BOARD_PLATFORM_GPU 			:= qcom-adreno330

# Wifi
BOARD_HAS_QCOM_WLAN              := true
BOARD_WLAN_DEVICE                := qcwcn
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_DRIVER_MODULE_PATH          := "/system/lib/modules/wlan.ko"
WIFI_DRIVER_MODULE_NAME          := "wlan"
WIFI_DRIVER_FW_PATH_STA          := "sta"
WIFI_DRIVER_FW_PATH_AP           := "ap"


# QCOM
BOARD_USES_QCOM_HARDWARE 			:= true
TARGET_USES_QCOM_BSP 				:= true
#COMMON_GLOBAL_CFLAGS += -DQCOM_HARDWARE 
#-DQCOM_BSP
#USE_DEVICE_SPECIFIC_QCOM_PROPRIETARY:= true


# Graphics
USE_OPENGL_RENDERER 				:= true
TARGET_USES_ION						:= true
#TARGET_USES_NEW_ION_API 			:= true
#TARGET_USES_OVERLAY 				:= true
TARGET_USES_C2D_COMPOSITION 		:= true
BOARD_EGL_CFG 						:= device/pantech/msm8974-common/configs/egl.cfg

TARGET_QCOM_DISPLAY_VARIANT 		:= caf-new
#TARGET_DISPLAY_USE_RETIRE_FENCE 	:= true

HAVE_ADRENO_SOURCE					:= false
OVERRIDE_RS_DRIVER 					:= libRSDriver_adreno.so

NUM_FRAMEBUFFER_SURFACE_BUFFERS 	:= 3

TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true

# Shader cache config options
# Maximum size of the  GLES Shaders that can be cached for reuse.
# Increase the size if shaders of size greater than 12KB are used.
MAX_EGL_CACHE_KEY_SIZE := 12*1024

# Maximum GLES shader cache size for each app to store the compiled shader
# binaries. Decrease the size if RAM or Flash Storage size is a limitation
# of the device.
MAX_EGL_CACHE_SIZE := 2048*1024

# Audio
TARGET_QCOM_AUDIO_VARIANT 			:= caf
BOARD_USES_ALSA_AUDIO				:= true

AUDIO_FEATURE_DISABLED_MULTI_VOICE_SESSIONS := true


# Media
TARGET_QCOM_MEDIA_VARIANT 			:= caf-new

# QCOM enhanced A/V
TARGET_ENABLE_QC_AV_ENHANCEMENTS 	:= true


# Camera
USE_DEVICE_SPECIFIC_CAMERA 	:= true
#TARGET_PROVIDES_CAMERA_HAL 	:= true
COMMON_GLOBAL_CFLAGS += -DVEGA_CAMERA_HARDWARE
COMMON_GLOBAL_CFLAGS += -DNEEDS_VECTORIMPL_SYMBOLS -DDISABLE_HW_ID_MATCH_CHECK


# Bluetooth
BOARD_HAVE_BLUETOOTH 				:= true
BOARD_HAVE_BLUETOOTH_QCOM 			:= true
BLUETOOTH_HCI_USE_MCT 				:= true

#Preload Boot Animation
TARGET_BOOTANIMATION_PRELOAD 		:= true

# GPS
#BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := $(TARGET_BOARD_PLATFORM)
#TARGET_NO_RPC := true
TARGET_PROVIDES_GPS_LOC_API := true

# PowerHAL
TARGET_POWERHAL_VARIANT				:= qcom
#CM_POWERHAL_EXTENSION				:= qcom

# LightHAL
TARGET_PROVIDES_LIBLIGHT 			:= true

# Override healthd HAL
BOARD_HAL_STATIC_LIBRARIES := libhealthd.qcom

# NFC
BOARD_HAVE_NFC 						:= true

# Enable WEBGL in WebKit
ENABLE_WEBGL 						:= true

# Webkit
TARGET_FORCE_CPU_UPLOAD 			:= true

# Charger
#BOARD_CHARGER_DISABLE_INIT_BLANK 	:= true
#BOARD_CHARGER_ENABLE_SUSPEND 		:= true

BOARD_HAL_STATIC_LIBRARIES			:= libdumpstate.msm8974

BOARD_HARDWARE_CLASS 				:= device/pantech/msm8974-common/cmhw/

BOARD_SEPOLICY_DIRS += \
        device/pantech/msm8974-common/sepolicy

# The list below is order dependent
BOARD_SEPOLICY_UNION += \
        file_contexts \
        app.te \
        device.te

TARGET_RELEASETOOLS_EXTENSIONS 		:= device/pantech/msm8974-common

BOARD_USES_QC_TIME_SERVICES := true

TARGET_EXCLUDE_GOOGLE_IME := true

PRODUCT_GMS_CLIENTID_BASE := android-pantech
