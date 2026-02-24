{
  lib,
  stdenv,
  cmake,
  extra-cmake-modules,
  pkg-config,
  qt5,
  qmlAsteroid,
  pname,
  src,
  description,
  homepage,
}:

stdenv.mkDerivation {
  inherit pname src;
  version = "unstable-2026-02-24";

  postPatch = ''
    # Our stack doesn't yet ship the full Nemo QML plugin set.
    # Keep app builds focused on core AsteroidApp/QML paths for now.
    if [ -f CMakeLists.txt ]; then
      sed -i '/ecm_find_qmlmodule/d' CMakeLists.txt
    fi
  '';

  nativeBuildInputs = [
    cmake
    extra-cmake-modules
    pkg-config
    qt5.wrapQtAppsHook
    qt5.qttools
  ];

  buildInputs = [
    qt5.qtbase
    qt5.qtdeclarative
    qt5.qtsvg
    qt5.qtsensors
    qmlAsteroid
  ];

  cmakeFlags = [
    "-DCMAKE_PREFIX_PATH=${qmlAsteroid}"
  ];

  meta = with lib; {
    inherit description homepage;
    license = licenses.gpl3Only;
    platforms = platforms.linux;
  };
}
