{ lib
, stdenv
, asteroidosMetaSmartwatch
}:

stdenv.mkDerivation {
  pname = "hoki-launcher-config";
  version = "unstable-2026-02-24";
  src = asteroidosMetaSmartwatch;

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    install -Dm644 \
      $src/meta-hoki/recipes-asteroid/asteroid-launcher/asteroid-launcher-configs/default.conf \
      $out/etc/default/asteroid-launcher
    runHook postInstall
  '';

  meta = with lib; {
    description = "AsteroidOS hoki launcher environment configuration";
    homepage = "https://github.com/AsteroidOS/meta-smartwatch";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
