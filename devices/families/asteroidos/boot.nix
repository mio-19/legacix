{ pkgs, asteroidosPackages, ... }:
{
  environment.systemPackages = [
    asteroidosPackages.bluebinder
    asteroidosPackages."qt5-qpa-hwcomposer-plugin"
    asteroidosPackages."android-init-hoki"
    asteroidosPackages."udev-droid-system"
    asteroidosPackages."swclock-offset"
    pkgs.openssh
    pkgs.bluez
  ];

  services.udev.packages = [
    asteroidosPackages."udev-droid-system"
  ];

  systemd.services.bluebinder = {
    description = "Simple proxy for Android binder Bluetooth through vhci";
    after = [ "droid-hal-init.service" ];
    before = [ "bluetooth.service" ];
    wantedBy = [ "graphical.target" ];
    serviceConfig = {
      Type = "notify";
      EnvironmentFile = "-/var/lib/environment/bluebinder/*.conf";
      ExecStartPre = "${asteroidosPackages.bluebinder}/libexec/bluebinder/bluebinder_wait.sh";
      ExecStart = "${asteroidosPackages.bluebinder}/bin/bluebinder";
      ExecStartPost = "${asteroidosPackages.bluebinder}/libexec/bluebinder/bluebinder_post.sh";
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
