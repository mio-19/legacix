{ lib
, stdenv
, asteroidosMetaSmartwatch
, asteroidosMetaAsteroid
}:

stdenv.mkDerivation {
  pname = "android-init-hoki";
  version = "unstable-2026-02-24";
  src = asteroidosMetaSmartwatch;

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -Dm644 \
      $src/meta-hoki/recipes-android/android-init/android-init/init.rc \
      $out/init.rc

    install -Dm644 \
      $src/meta-hoki/recipes-android/android-init/android-init/android-init.service \
      $out/lib/systemd/system/android-init.service

    install -Dm644 \
      ${asteroidosMetaAsteroid}/recipes-android/android-init/android-init/android-boot-completed.service \
      $out/lib/systemd/user/android-boot-completed.service

    install -Dm644 \
      $src/meta-hoki/recipes-android/android-init/android-init/plat_property_contexts \
      $out/etc/android-init/plat_property_contexts

    install -Dm644 \
      $src/meta-hoki/recipes-android/android-init/android-init/nonplat_property_contexts \
      $out/etc/android-init/nonplat_property_contexts

    runHook postInstall
  '';

  meta = with lib; {
    description = "Android init service and property contexts for hoki";
    homepage = "https://github.com/AsteroidOS/meta-smartwatch";
    license = licenses.asl20;
    platforms = platforms.linux;
  };
}
