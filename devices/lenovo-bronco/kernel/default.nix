{
  mobile-nixos,
  droidianKernelLenovoBronco,
  ...
}:

mobile-nixos.kernel-builder {
  version = "5.10.240";

  src = droidianKernelLenovoBronco;
  configfile = "${droidianKernelLenovoBronco}/arch/arm64/configs/bronco_defconfig";

  # Droidian builds this target without modules in its packaging flow.
  isModular = false;

  # Vendor kernels often carry strict warning policies that break with
  # newer toolchains.
  enableRemovingWerror = true;
}
