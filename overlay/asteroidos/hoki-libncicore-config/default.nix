{ lib
, stdenv
, asteroidosMetaSmartwatch
}:

stdenv.mkDerivation {
  pname = "hoki-libncicore-config";
  version = "unstable-2026-02-24";
  src = asteroidosMetaSmartwatch;

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    install -Dm644 \
      $src/meta-hoki/recipes-nemomobile/libnci/libncicore/libncicore.conf \
      $out/etc/libncicore.conf
    runHook postInstall
  '';

  meta = with lib; {
    description = "hoki libncicore configuration override";
    homepage = "https://github.com/AsteroidOS/meta-smartwatch";
    license = licenses.bsd3;
    platforms = platforms.linux;
  };
}
