{ lib
, stdenv
, pkg-config
, qt5
, libhybris
, android-headers
, libdrm
, merHybrisQt5QpaHwcomposerPlugin
}:

stdenv.mkDerivation rec {
  pname = "qt5-qpa-hwcomposer-plugin";
  version = "unstable-2026-02-24";
  src = merHybrisQt5QpaHwcomposerPlugin;
  sourceRoot = "source/hwcomposer";

  nativeBuildInputs = [
    pkg-config
    qt5.qmake
  ];

  buildInputs = [
    qt5.qtbase
    qt5.qtwayland
    libhybris
    android-headers
    libdrm
  ];

  configurePhase = ''
    runHook preConfigure
    qmake hwcomposer.pro
    runHook postConfigure
  '';

  buildPhase = ''
    runHook preBuild
    make
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    make install INSTALL_ROOT=$out
    runHook postInstall
  '';

  meta = with lib; {
    description = "Qt QPA hwcomposer platform plugin used by AsteroidOS/Lipstick";
    homepage = "https://github.com/mer-hybris/qt5-qpa-hwcomposer-plugin";
    license = licenses.lgpl21Only;
    platforms = platforms.linux;
  };
}
