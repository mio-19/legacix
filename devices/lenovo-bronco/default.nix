{ pkgs, config, droidianKernelLenovoBronco, ... }:

let
  adaptation = pkgs.callPackage ./adaptation { };
in
{
  mobile.device.name = "lenovo-bronco";
  mobile.device.identity = {
    name = "ThinkPhone by Motorola";
    manufacturer = "Motorola";
  };

  mobile.hardware = {
    soc = "qualcomm-sm8475";
    ram = 1024 * 8;
    screen = {
      width = 1080;
      height = 2400;
    };
  };

  mobile.boot.stage-1.kernel.package = pkgs.callPackage ./kernel {
    inherit droidianKernelLenovoBronco;
  };

  mobile.system.system = "aarch64-linux";
  mobile.system.type = "android";
  mobile.system.android = {
    device_name = "bronco";
    ab_partitions = true;

    bootimg.flash = {
      offset_base = "0x00000000";
      offset_kernel = "0x00008000";
      offset_ramdisk = "0x01000000";
      offset_second = "0x00f00000";
      offset_tags = "0x00000100";
      pagesize = "4096";
    };
  };

  boot.kernelParams = [
    "console=ttyMSM0,115200,n8"
    "androidboot.console=ttyMSM0"
    "androidboot.hardware=qcom"
    "androidboot.bootdevice=1d84000.ufshc"
    "androidboot.memcg=1"
    "loop.max_part=7"
    "cgroup.memory=nokmem,nosocket"
  ];

  mobile.usb.mode = "gadgetfs";
  mobile.usb.idVendor = "22B8";
  mobile.usb.idProduct = "2E80";
  mobile.usb.gadgetfs.functions = {
    rndis = "gsi.rndis";
    adb = "ffs.adb";
  };

  services.udev.packages = [ adaptation ];
}
