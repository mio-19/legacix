{ lib, ... }:

{
  imports = [
    ../families/mainline-chromeos-mt8188
  ];

  mobile.device.name = "lenovo-ciri";
  mobile.device.identity = {
    name = "Chromebook Duet 11\" (2024)";
    manufacturer = "Lenovo";
  };
  mobile.device.supportLevel = "best-effort";

  mobile.hardware = {
    # Panel is portrait CW compared to keyboard attachment.
    screen = {
      width = 1200;
      height = 1920;
    };
  };

  # Ensure orientation match with keyboard.
  services.udev.extraHwdb = lib.mkBefore ''
    sensor:modalias:platform:*
      ACCEL_MOUNT_MATRIX=0, 1, 0; -1, 0, 0; 0, 0, -1
  '';
}
