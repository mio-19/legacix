{
  mobile-nixos,
  fetchgit,
  ...
}:

(
mobile-nixos.kernel-builder {
  # ChromeOS downstream kernel used on geralt/ciri devices.
  version = "6.1.157";
  configfile = ./config.aarch64;

  src = fetchgit {
    url = "https://chromium.googlesource.com/chromiumos/third_party/kernel";
    rev = "00bda2c5ccc910cab1be28bae1da9a5854676db3";
    hash = "sha256-AloRjHG4Ch5Uazugq+seMLVJSpf+VoZeYGOI+syfmX8=";
  };

  isModular = true;
  isCompressed = false;
}
).overrideAttrs (_: {
  # Downstream kernel config drifts; do not hard-fail on normalization.
  forceNormalizedConfig = false;
  enableConfigValidation = false;
})
