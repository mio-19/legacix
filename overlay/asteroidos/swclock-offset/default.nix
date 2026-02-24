{ lib
, stdenv
, fetchgit
}:

stdenv.mkDerivation rec {
  pname = "swclock-offset";
  version = "unstable-2026-02-24";

  src = fetchgit {
    url = "https://gitlab.com/postmarketOS/swclock-offset.git";
    rev = "6a4e4dcee814c7cfc22e0f69a6dc510086cb7abf";
    hash = "sha256-Qqvu4GH016pz8+iMDECE2zXCPKhDPHo3CPzPPgJhITw=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    make install DESTDIR=$out
    rm -rf $out/etc/init.d
    runHook postInstall
  '';

  meta = with lib; {
    description = "RTC offset synchronization helper for Android devices";
    homepage = "https://gitlab.com/postmarketOS/swclock-offset";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
  };
}
