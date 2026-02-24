{
  mobile-nixos
, asteroidosMetaSmartwatch ? null
, fossilKernelMsmFossilCw ? null
, ...
}:

let
  _ = if asteroidosMetaSmartwatch == null then
    throw ''
      devices/hoki requires the flake input asteroidos-meta-smartwatch.
      Use this repository through flake outputs.
    ''
  else
    null;

  __ = if fossilKernelMsmFossilCw == null then
    throw ''
      devices/hoki requires the flake input fossil-kernel-msm-fossil-cw.
      Use this repository through flake outputs.
    ''
  else
    null;

  asteroidosHokiKernel = "${asteroidosMetaSmartwatch}/meta-hoki/recipes-kernel/linux";
in
mobile-nixos.kernel-builder-gcc8 {
  version = "4.14";
  modDirVersion = "4.14.206";
  configfile = "${asteroidosHokiKernel}/linux-hoki/defconfig";
  src = fossilKernelMsmFossilCw;

  patches = [
    "${asteroidosHokiKernel}/files/0001-dts-Add-hoki-device-trees.patch"
    "${asteroidosHokiKernel}/files/0002-mmc-Fix-embedded_sdio_data-duplicate-definition.patch"
    "${asteroidosHokiKernel}/files/0003-video-fbdev-msm-Provide-mdss_dsi_switch_page.patch"
    "${asteroidosHokiKernel}/files/0004-usb-hcd-Handle-when-host-mode-isn-t-available.patch"
    "${asteroidosHokiKernel}/files/0005-initramfs-Don-t-skip-initramfs.patch"
    "${asteroidosHokiKernel}/files/0006-ARM-8933-1-replace-Sun-Solaris-style-flag-on-section.patch"
  ];

  # AsteroidOS currently uses gcc8; use existing builder variant for now.
  enableConfigValidation = false;
  enableRemovingWerror = true;
  isModular = false;
  isImageGzDtb = true;
}
