{ lib
, stdenv
, asteroidosMetaSmartwatch
}:

stdenv.mkDerivation {
  pname = "hoki-ngfd-config";
  version = "unstable-2026-02-24";
  src = asteroidosMetaSmartwatch;

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    install -Dm644 \
      $src/meta-hoki/recipes-nemomobile/ngfd/ngfd/51-ffmemless.ini \
      $out/share/ngfd/plugins.d/51-ffmemless.ini
    runHook postInstall
  '';

  meta = with lib; {
    description = "hoki ngfd plugin configuration override";
    homepage = "https://github.com/AsteroidOS/meta-smartwatch";
    license = licenses.lgpl21Only;
    platforms = platforms.linux;
  };
}
