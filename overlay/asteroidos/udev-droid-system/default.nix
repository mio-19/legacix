{ lib
, stdenv
, asteroidosMetaAsteroid
}:

stdenv.mkDerivation {
  pname = "udev-droid-system";
  version = "unstable-2026-02-24";
  src = asteroidosMetaAsteroid;

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    install -Dm644 \
      $src/recipes-android/udev-droid-system/udev-droid-system/998-droid-system.rules \
      $out/lib/udev/rules.d/998-droid-system.rules
    runHook postInstall
  '';

  meta = with lib; {
    description = "Android compatibility udev rules for /dev block/platform symlinks";
    homepage = "https://github.com/AsteroidOS/meta-asteroid";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
  };
}
