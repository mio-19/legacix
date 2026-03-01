{ config, lib, pkgs, ... }:

{
  imports = [
    ../mainline-chromeos
  ];

  mobile.hardware = {
    soc = "mediatek-mt8188";
    ram = lib.mkDefault (1024 * 8);
  };

  mobile.boot.stage-1 = {
    kernel.package = pkgs.callPackage ./kernel {};
  };

  mobile.system.depthcharge.kpart = {
    dtbs = "${config.mobile.boot.stage-1.kernel.package}/dtbs/mediatek";
  };

  # Serial console on ttyS0, using a suzyqable or equivalent.
  mobile.boot.serialConsole = "ttyS0,115200n8";

  systemd.services."serial-getty@ttyS0" = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
  };

  mobile.device.firmware = pkgs.callPackage ./firmware {};
  mobile.boot.stage-1.firmware = [
    config.mobile.device.firmware
  ];

  mobile.kernel.structuredConfig = [
    (helpers: with helpers; {
      # Needed for some hid-over-i2c trackpads.
      HID_RMI = yes;
    })
  ];
}
