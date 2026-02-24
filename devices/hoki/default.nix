{
  pkgs,
  lib,
  asteroidosMetaSmartwatch ? null,
  fossilKernelMsmFossilCw ? null,
  ...
}:

{
  mobile.device.name = "hoki";
  mobile.device.identity = {
    # Fossil Gen 6 platform, AsteroidOS codename: hoki
    name = "Gen 6 (hoki)";
    manufacturer = "Fossil";
  };

  mobile.hardware = {
    soc = "qualcomm-sdm429w";
    ram = 1024;
    screen = {
      width = 416;
      height = 416;
    };
  };

  mobile.boot.stage-1.kernel.package = pkgs.callPackage ./kernel {
    inherit
      asteroidosMetaSmartwatch
      fossilKernelMsmFossilCw
    ;
  };

  mobile.system.type = "android";
  mobile.system.android = {
    device_name = "hoki";
    bootimg.flash = {
      offset_base = "0x80000000";
      offset_kernel = "0x00008000";
      offset_second = "0x00f00000";
      offset_ramdisk = "0x01000000";
      offset_tags = "0x00000100";
      pagesize = "4096";
    };
  };

  # Boot args adapted from AsteroidOS meta-hoki linux-hoki/img_info.
  boot.kernelParams = [
    "console=ttyMSM0,115200,n8"
    "androidboot.console=ttyMSM0"
    "androidboot.selinux=permissive"
    "androidboot.hardware=hoki"
    "user_debug=30"
    "msm_rtb.filter=0x237"
    "ehci-hcd.park=3"
    "androidboot.bootdevice=7824900.sdhci"
    "lpm_levels.sleep_disabled=1"
    "earlycon=msm_serial_dm,0x78b0000"
    "vmalloc=300M"
    "androidboot.usbconfigfs=true"
    "loop.max_part=7"
    "androidboot.memcg=true"
    "cgroup.memory=nokmem,nosocket"
    "buildvariant=user"
    "audit=0"
  ];

  mobile.usb.mode = "gadgetfs";
  # Temporary IDs until verified on-device.
  mobile.usb.idVendor = "18D1";
  mobile.usb.idProduct = "D001";
  mobile.usb.gadgetfs.functions = {
    rndis = "gsi.rndis";
    adb = "ffs.adb";
  };

  environment.systemPackages =
    lib.optionals (pkgs ? asteroidos && pkgs.asteroidos ? qml-asteroid) [
      pkgs.asteroidos.qml-asteroid
    ]
    ++ lib.optionals (pkgs ? asteroidos && pkgs.asteroidos ? bluebinder) [
      pkgs.asteroidos.bluebinder
    ]
    ++ lib.optionals (pkgs ? asteroidos && pkgs.asteroidos ? "qt5-qpa-hwcomposer-plugin") [
      pkgs.asteroidos."qt5-qpa-hwcomposer-plugin"
    ]
    ++ lib.optionals (pkgs ? asteroidos && pkgs.asteroidos ? hoki-underclock) [
      pkgs.asteroidos.hoki-underclock
    ]
    ++ lib.optionals (pkgs ? asteroidos && pkgs.asteroidos ? "android-init-hoki") [
      pkgs.asteroidos."android-init-hoki"
    ]
    ++ lib.optionals (pkgs ? asteroidos && pkgs.asteroidos ? "udev-droid-system") [
      pkgs.asteroidos."udev-droid-system"
    ]
    ++ lib.optionals (pkgs ? asteroidos && pkgs.asteroidos ? "swclock-offset") [
      pkgs.asteroidos."swclock-offset"
    ]
    ++ lib.optionals (pkgs ? asteroidos && pkgs.asteroidos ? "asteroid-hrm") [
      pkgs.asteroidos."asteroid-hrm"
    ]
    ++ lib.optionals (pkgs ? asteroidos && pkgs.asteroidos ? "asteroid-compass") [
      pkgs.asteroidos."asteroid-compass"
    ]
  ;

  environment.etc = lib.mkMerge [
    (lib.mkIf (pkgs ? asteroidos && pkgs.asteroidos ? hoki-launcher-config) {
      "default/asteroid-launcher".source = "${pkgs.asteroidos.hoki-launcher-config}/etc/default/asteroid-launcher";
    })
    (lib.mkIf (pkgs ? asteroidos && pkgs.asteroidos ? "hoki-libncicore-config") {
      "libncicore.conf".source = "${pkgs.asteroidos."hoki-libncicore-config"}/etc/libncicore.conf";
    })
    (lib.mkIf (pkgs ? asteroidos && pkgs.asteroidos ? "hoki-ngfd-config") {
      "ngfd/plugins.d/51-ffmemless.ini".source = "${pkgs.asteroidos."hoki-ngfd-config"}/share/ngfd/plugins.d/51-ffmemless.ini";
    })
    (lib.mkIf (pkgs ? asteroidos && pkgs.asteroidos ? "android-init-hoki") {
      "android-init/plat_property_contexts".source = "${pkgs.asteroidos."android-init-hoki"}/etc/android-init/plat_property_contexts";
      "android-init/nonplat_property_contexts".source = "${pkgs.asteroidos."android-init-hoki"}/etc/android-init/nonplat_property_contexts";
      "android-init/init.rc".source = "${pkgs.asteroidos."android-init-hoki"}/init.rc";
    })
  ];

  services.udev.packages = lib.optionals (pkgs ? asteroidos && pkgs.asteroidos ? "udev-droid-system") [
    pkgs.asteroidos."udev-droid-system"
  ];

  systemd.services.bluebinder = lib.mkIf (pkgs ? asteroidos && pkgs.asteroidos ? bluebinder) {
    description = "Simple proxy for Android binder Bluetooth through vhci";
    after = [ "droid-hal-init.service" ];
    before = [ "bluetooth.service" ];
    wantedBy = [ "graphical.target" ];
    serviceConfig = {
      Type = "notify";
      EnvironmentFile = "-/var/lib/environment/bluebinder/*.conf";
      ExecStartPre = "${pkgs.asteroidos.bluebinder}/libexec/bluebinder/bluebinder_wait.sh";
      ExecStart = "${pkgs.asteroidos.bluebinder}/bin/bluebinder";
      ExecStartPost = "${pkgs.asteroidos.bluebinder}/libexec/bluebinder/bluebinder_post.sh";
      Restart = "always";
      TimeoutStartSec = "60";
      CapabilityBoundingSet = "CAP_DAC_READ_SEARCH";
      DeviceAllow = [ "/dev/hwbinder rw" "/dev/vhci rw" "/dev/rfkill r" ];
      DevicePolicy = "strict";
      NoNewPrivileges = true;
      RestrictAddressFamilies = "AF_BLUETOOTH";
      PrivateTmp = true;
      ProtectHome = true;
      ProtectSystem = "full";
    };
  };

  systemd.services.underclock = lib.mkIf (pkgs ? asteroidos && pkgs.asteroidos ? hoki-underclock) {
    description = "Underclock CPU/GPU to reduce hoki power usage";
    wantedBy = [ "basic.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 20";
      ExecStart = "${pkgs.asteroidos.hoki-underclock}/bin/underclock";
    };
  };

  systemd.services.android-init = lib.mkIf (pkgs ? asteroidos && pkgs.asteroidos ? "android-init-hoki") {
    description = "/system/bin/init compatibility service for vendor daemons";
    after = [ "local-fs.target" ];
    before = [ "basic.target" "network.target" "bluetooth.service" ];
    wantedBy = [ "graphical.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStartPre = "${pkgs.coreutils}/bin/touch /dev/.coldboot_done";
      ExecStart = "/usr/libexec/hal-droid/system/bin/init";
    };
  };
}
