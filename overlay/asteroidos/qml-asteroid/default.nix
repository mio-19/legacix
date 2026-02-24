{ lib
, stdenv
, cmake
, extra-cmake-modules
, pkg-config
, qt5
, asteroidosQmlAsteroid
}:

stdenv.mkDerivation rec {
  pname = "qml-asteroid";
  version = "2.0.0";
  src = asteroidosQmlAsteroid;

  nativeBuildInputs = [
    cmake
    extra-cmake-modules
    pkg-config
    qt5.wrapQtAppsHook
  ];

  buildInputs = [
    qt5.qtbase
    qt5.qtdeclarative
    qt5.qtsvg
    qt5.qtwayland
  ];

  cmakeFlags = [
    "-DWITH_ASTEROIDAPP=OFF"
    "-DWITH_CMAKE_MODULES=ON"
  ];

  meta = with lib; {
    description = "QML components, styles and demos for AsteroidOS";
    homepage = "https://github.com/AsteroidOS/qml-asteroid";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
