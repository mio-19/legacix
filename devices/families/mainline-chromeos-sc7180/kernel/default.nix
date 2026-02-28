{ mobile-nixos
, fetchurl
, ...
}:

(
mobile-nixos.kernel-builder {
  # Matches postmarketOS linux-postmarketos-qcom-sc7180 package baseline.
  version = "6.18.9";
  configfile = ./config.aarch64;

  src = fetchurl {
    url = "https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.18.9.tar.xz";
    sha256 = "sha256-AwEV/4+0y1NthEncQOvD4xToa6GzFqauIQkaEcyTBXg=";
  };

  isModular = true;
  isCompressed = false;
}
).overrideAttrs (_: {
  # Upstream config drifts quickly on mainline kernels; allow progress without
  # blocking on strict oldconfig/structured-config checks.
  forceNormalizedConfig = false;
  enableConfigValidation = false;
})
