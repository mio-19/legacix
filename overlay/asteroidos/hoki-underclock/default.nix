{ lib
, stdenv
, asteroidosMetaSmartwatch
}:

stdenv.mkDerivation {
  pname = "hoki-underclock";
  version = "unstable-2026-02-24";
  src = asteroidosMetaSmartwatch;

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    install -Dm755 \
      $src/meta-hoki/recipes-core/underclock/underclock/underclock \
      $out/bin/underclock
    install -Dm644 \
      $src/meta-hoki/recipes-core/underclock/underclock/underclock.service \
      $out/lib/systemd/system/underclock.service
    runHook postInstall
  '';

  meta = with lib; {
    description = "AsteroidOS hoki underclock helper";
    homepage = "https://github.com/AsteroidOS/meta-smartwatch";
    license = licenses.gpl2Only;
    platforms = platforms.linux;
  };
}
