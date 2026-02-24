{ lib
, stdenv
, pkg-config
, glib
, libgbinder
, bluez
, systemd
, merHybrisBluebinder
}:

stdenv.mkDerivation rec {
  pname = "bluebinder";
  version = "unstable-2026-02-24";
  src = merHybrisBluebinder;

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    glib
    libgbinder
    bluez
    systemd
  ];

  makeFlags = [
    "USE_SYSTEMD=1"
  ];

  installPhase = ''
    runHook preInstall

    install -Dm755 bluebinder $out/bin/bluebinder
    install -Dm755 bluebinder_wait.sh $out/libexec/bluebinder/bluebinder_wait.sh
    install -Dm755 bluebinder_post.sh $out/libexec/bluebinder/bluebinder_post.sh
    install -Dm644 bluebinder.service $out/lib/systemd/system/bluebinder.service

    substituteInPlace $out/lib/systemd/system/bluebinder.service \
      --replace-fail /usr/sbin/bluebinder $out/bin/bluebinder \
      --replace-fail /usr/bin/droid/bluebinder_wait.sh $out/libexec/bluebinder/bluebinder_wait.sh \
      --replace-fail /usr/bin/droid/bluebinder_post.sh $out/libexec/bluebinder/bluebinder_post.sh

    runHook postInstall
  '';

  meta = with lib; {
    description = "Android binder Bluetooth proxy service used by AsteroidOS";
    homepage = "https://github.com/mer-hybris/bluebinder";
    license = licenses.gpl2Only;
    platforms = platforms.linux;
  };
}
