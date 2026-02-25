{
  mobile-nixos
, asteroidosMetaSmartwatch
, fossilKernelMsmFossilCw
, cpio
, ...
}:

let asteroidosHokiKernel = "${asteroidosMetaSmartwatch}/meta-hoki/recipes-kernel/linux"; in
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

  postPatch = ''
    # Older/vendor trees may not provide dtbs_install; mobile-nixos builder calls it.
    # Add a compatibility no-op target so install phase can continue.
    if ! grep -q '^dtbs_install:' Makefile; then
      cat >> Makefile <<'EOF'
dtbs_install:
	@true
EOF
    fi
  '';

  # AsteroidOS currently uses gcc8; use existing builder variant for now.
  enableConfigValidation = false;
  enableRemovingWerror = true;
  isModular = false;
  isImageGzDtb = true;
  nativeBuildInputs = [ cpio ];
}
