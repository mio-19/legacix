{
  pkgs,
  asteroidosMetaSmartwatch,
  asteroidosMetaAsteroid,
  asteroidosAsteroidHrm,
  asteroidosAsteroidCompass,
  asteroidosQmlAsteroid,
  merHybrisBluebinder,
  merHybrisQt5QpaHwcomposerPlugin,
  fossilKernelMsmFossilCw,
  ...
}:

let
  asteroidos =
    let
      qmlAsteroid = pkgs.callPackage ../../overlay/asteroidos/qml-asteroid {
        inherit asteroidosQmlAsteroid;
      };
    in
    {
      qml-asteroid = qmlAsteroid;
      bluebinder = pkgs.callPackage ../../overlay/asteroidos/bluebinder {
        inherit merHybrisBluebinder;
      };
      "qt5-qpa-hwcomposer-plugin" = pkgs.callPackage ../../overlay/asteroidos/qt5-qpa-hwcomposer-plugin {
        inherit merHybrisQt5QpaHwcomposerPlugin;
      };
      hoki-underclock = pkgs.callPackage ../../overlay/asteroidos/hoki-underclock {
        inherit asteroidosMetaSmartwatch;
      };
      "android-init-hoki" = pkgs.callPackage ../../overlay/asteroidos/android-init-hoki {
        inherit asteroidosMetaSmartwatch asteroidosMetaAsteroid;
      };
      "udev-droid-system" = pkgs.callPackage ../../overlay/asteroidos/udev-droid-system {
        inherit asteroidosMetaAsteroid;
      };
      "swclock-offset" = pkgs.callPackage ../../overlay/asteroidos/swclock-offset { };
      "hoki-launcher-config" = pkgs.callPackage ../../overlay/asteroidos/hoki-launcher-config {
        inherit asteroidosMetaSmartwatch;
      };
      "hoki-libncicore-config" = pkgs.callPackage ../../overlay/asteroidos/hoki-libncicore-config {
        inherit asteroidosMetaSmartwatch;
      };
      "hoki-ngfd-config" = pkgs.callPackage ../../overlay/asteroidos/hoki-ngfd-config {
        inherit asteroidosMetaSmartwatch;
      };
      "asteroid-hrm" = pkgs.callPackage ../../overlay/asteroidos/asteroid-hrm {
        inherit asteroidosAsteroidHrm;
        qmlAsteroid = qmlAsteroid;
      };
      "asteroid-compass" = pkgs.callPackage ../../overlay/asteroidos/asteroid-compass {
        inherit asteroidosAsteroidCompass;
        qmlAsteroid = qmlAsteroid;
      };
    };
in
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

  environment.systemPackages = [
    asteroidos.qml-asteroid
    asteroidos.bluebinder
    asteroidos."qt5-qpa-hwcomposer-plugin"
    asteroidos.hoki-underclock
    asteroidos."android-init-hoki"
    asteroidos."udev-droid-system"
    asteroidos."swclock-offset"
    asteroidos."asteroid-hrm"
    asteroidos."asteroid-compass"
    pkgs.connman
    pkgs.ofono
    pkgs.geoclue2
    pkgs.pulseaudio
    pkgs.openssh
    pkgs.bluez
  ];

  environment.etc = {
    "default/asteroid-launcher".source = "${asteroidos."hoki-launcher-config"}/etc/default/asteroid-launcher";
    "libncicore.conf".source = "${asteroidos."hoki-libncicore-config"}/etc/libncicore.conf";
    "ngfd/plugins.d/51-ffmemless.ini".source = "${asteroidos."hoki-ngfd-config"}/share/ngfd/plugins.d/51-ffmemless.ini";
    "android-init/plat_property_contexts".source = "${asteroidos."android-init-hoki"}/etc/android-init/plat_property_contexts";
    "android-init/nonplat_property_contexts".source = "${asteroidos."android-init-hoki"}/etc/android-init/nonplat_property_contexts";
    "android-init/init.rc".source = "${asteroidos."android-init-hoki"}/init.rc";
  };

  services.udev.packages = [
    asteroidos."udev-droid-system"
  ];

  systemd.services.bluebinder = {
    description = "Simple proxy for Android binder Bluetooth through vhci";
    after = [ "droid-hal-init.service" ];
    before = [ "bluetooth.service" ];
    wantedBy = [ "graphical.target" ];
    serviceConfig = {
      Type = "notify";
      EnvironmentFile = "-/var/lib/environment/bluebinder/*.conf";
      ExecStartPre = "${asteroidos.bluebinder}/libexec/bluebinder/bluebinder_wait.sh";
      ExecStart = "${asteroidos.bluebinder}/bin/bluebinder";
      ExecStartPost = "${asteroidos.bluebinder}/libexec/bluebinder/bluebinder_post.sh";
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

  systemd.services.underclock = {
    description = "Underclock CPU/GPU to reduce hoki power usage";
    wantedBy = [ "basic.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 20";
      ExecStart = "${asteroidos.hoki-underclock}/bin/underclock";
    };
  };

  systemd.services.android-init = {
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
