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

  postPatch = ''
    # Build AsteroidApp without mlite/mapplauncherd so downstream Asteroid apps can
    # link against a basic app wrapper in this Nix stack.
    substituteInPlace CMakeLists.txt \
      --replace-fail "    find_package(Mlite5 MODULE REQUIRED)" "" \
      --replace-fail "    find_package(Mapplauncherd_qt5 MODULE REQUIRED)" ""

    substituteInPlace src/app/CMakeLists.txt \
      --replace-fail "PRIVATE" "" \
      --replace-fail "Mlite5::Mlite5" "" \
      --replace-fail "Mapplauncherd_qt5::Mapplauncherd_qt5" ""

    substituteInPlace src/app/asteroidapp.cpp \
      --replace-fail "#include <MDesktopEntry>" "" \
      --replace-fail "#include <mdeclarativecache5/MDeclarativeCache>" "" \
      --replace-fail "            app = MDeclarativeCache::qApplication(argc, argv);" "            app = new QGuiApplication(argc, argv);" \
      --replace-fail "        QQuickView *view = MDeclarativeCache::qQuickView();" "        QQuickView *view = new QQuickView();"

    sed -i '/MDesktopEntry entry/,/}/c\\        view->setTitle(appName());' src/app/asteroidapp.cpp
  '';

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
    "-DWITH_CMAKE_MODULES=ON"
  ];

  meta = with lib; {
    description = "QML components, styles and demos for AsteroidOS";
    homepage = "https://github.com/AsteroidOS/qml-asteroid";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
