{ config, lib, pkgs, ... }:

{
  imports = [
    ../families/mainline-chromeos-sc7180
  ];

  mobile.device.name = "lenovo-wormdingler";
  mobile.device.identity = {
    name = "Chromebook Duet 3 (11”)";
    manufacturer = "Lenovo";
  };
  mobile.device.supportLevel = "supported";

  mobile.hardware = {
    # Keep postmarketOS-based kernel/userspace assumptions explicit.
    soc = "qualcomm-sc7180";
    ram = 1024 * 4; # Up to 8GiB
    screen = {
      # Panel is portrait CW compared to keyboard attachment.
      width = 1200; height = 2000;
    };
  };

  # Battery modules required on this hardware.
  mobile.boot.stage-1 = {
    kernel.modular = true;
    kernel.additionalModules = [
      # Breaks udev if builtin or loaded before udev runs.
      # Using `additionalModules` means udev will load them as needed.
      "sbs-battery"
      "sbs-charger"
      "sbs-manager"
    ];
  };

  mobile.system.depthcharge.kpart = {
    dtbs = lib.mkForce "${config.mobile.boot.stage-1.kernel.package}/dtbs/qcom";
  };

  # Ensure orientation match with keyboard.
  services.udev.extraHwdb = lib.mkBefore ''
    sensor:accel-display:modalias:platform:cros-ec-accel:*
      ACCEL_MOUNT_MATRIX=0, 1, 0; -1, 0, 0; 0, 0, -1
  '';
  # Reuse postmarketOS quirk: iio-sensor-proxy polling fallback for cros-ec accel.
  services.udev.extraRules = lib.mkBefore ''
    SUBSYSTEM=="iio", TEST=="in_accel_x_raw", TEST=="in_accel_y_raw", TEST=="in_accel_z_raw", ENV{IIO_SENSOR_PROXY_TYPE}="iio-poll-accel"
  '';

  # Keep this device-local firmware package naming for current docs/config users.
  mobile.device.firmware = lib.mkForce (pkgs.callPackage ./firmware {});
  mobile.boot.stage-1.firmware = lib.mkForce [ config.mobile.device.firmware ];
  hardware.firmware = lib.mkForce [ config.mobile.device.firmware ];

  nixpkgs.overlays = [
    (final: _: {
      lenovo-wormdingler-unredistributable-firmware = final.callPackage ./firmware/non-redistributable.nix {};
    })
  ];
}
