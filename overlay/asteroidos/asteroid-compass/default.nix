{ lib
, stdenv
, cmake
, extra-cmake-modules
, pkg-config
, qt5
, asteroidosAsteroidCompass
, qmlAsteroid
}:

stdenv.mkDerivation rec {
  pname = "asteroid-compass";
  version = "unstable-2026-02-24";
  src = asteroidosAsteroidCompass;

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
    qt5.qtsensors
    qt5.qtsvg
    qmlAsteroid
  ];

  cmakeFlags = [
    "-DCMAKE_PREFIX_PATH=${qmlAsteroid}"
  ];

  meta = with lib; {
    description = "AsteroidOS compass app";
    homepage = "https://github.com/AsteroidOS/asteroid-compass";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
  };
}
