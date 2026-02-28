{
  pkgs,
  asteroidosMetaSmartwatch,
  asteroidosMetaAsteroid,
  asteroidosAsteroidHrm,
  asteroidosAsteroidCompass,
  asteroidosAsteroidCalculator,
  asteroidosAsteroidCalendar,
  asteroidosAsteroidDiamonds,
  asteroidosAsteroidFlashlight,
  asteroidosAsteroidMusic,
  asteroidosAsteroidStopwatch,
  asteroidosAsteroidTimer,
  asteroidosAsteroidWeather,
  asteroidosQmlAsteroid,
  merHybrisBluebinder,
  merHybrisQt5QpaHwcomposerPlugin,
}:
let
  qmlAsteroid = pkgs.callPackage ../../../overlay/asteroidos/qml-asteroid {
    inherit asteroidosQmlAsteroid;
  };
in
{
  qml-asteroid = qmlAsteroid;
  bluebinder = pkgs.callPackage ../../../overlay/asteroidos/bluebinder {
    inherit merHybrisBluebinder;
  };
  "qt5-qpa-hwcomposer-plugin" = pkgs.callPackage ../../../overlay/asteroidos/qt5-qpa-hwcomposer-plugin {
    inherit merHybrisQt5QpaHwcomposerPlugin;
  };
  hoki-underclock = pkgs.callPackage ../../../overlay/asteroidos/hoki-underclock {
    inherit asteroidosMetaSmartwatch;
  };
  "android-init-hoki" = pkgs.callPackage ../../../overlay/asteroidos/android-init-hoki {
    inherit asteroidosMetaSmartwatch asteroidosMetaAsteroid;
  };
  "udev-droid-system" = pkgs.callPackage ../../../overlay/asteroidos/udev-droid-system {
    inherit asteroidosMetaAsteroid;
  };
  "swclock-offset" = pkgs.callPackage ../../../overlay/asteroidos/swclock-offset { };
  "hoki-launcher-config" = pkgs.callPackage ../../../overlay/asteroidos/hoki-launcher-config {
    inherit asteroidosMetaSmartwatch;
  };
  "hoki-libncicore-config" = pkgs.callPackage ../../../overlay/asteroidos/hoki-libncicore-config {
    inherit asteroidosMetaSmartwatch;
  };
  "hoki-ngfd-config" = pkgs.callPackage ../../../overlay/asteroidos/hoki-ngfd-config {
    inherit asteroidosMetaSmartwatch;
  };
  "asteroid-hrm" = pkgs.callPackage ../../../overlay/asteroidos/asteroid-hrm {
    inherit asteroidosAsteroidHrm;
    inherit qmlAsteroid;
  };
  "asteroid-compass" = pkgs.callPackage ../../../overlay/asteroidos/asteroid-compass {
    inherit asteroidosAsteroidCompass;
    inherit qmlAsteroid;
  };
  "asteroid-calculator" = pkgs.callPackage ../../../overlay/asteroidos/asteroid-qml-app {
    pname = "asteroid-calculator";
    src = asteroidosAsteroidCalculator;
    inherit qmlAsteroid;
    description = "AsteroidOS calculator app";
    homepage = "https://github.com/AsteroidOS/asteroid-calculator";
  };
  "asteroid-calendar" = pkgs.callPackage ../../../overlay/asteroidos/asteroid-qml-app {
    pname = "asteroid-calendar";
    src = asteroidosAsteroidCalendar;
    inherit qmlAsteroid;
    description = "AsteroidOS calendar app";
    homepage = "https://github.com/AsteroidOS/asteroid-calendar";
  };
  "asteroid-diamonds" = pkgs.callPackage ../../../overlay/asteroidos/asteroid-qml-app {
    pname = "asteroid-diamonds";
    src = asteroidosAsteroidDiamonds;
    inherit qmlAsteroid;
    description = "AsteroidOS diamonds game";
    homepage = "https://github.com/AsteroidOS/asteroid-diamonds";
  };
  "asteroid-flashlight" = pkgs.callPackage ../../../overlay/asteroidos/asteroid-qml-app {
    pname = "asteroid-flashlight";
    src = asteroidosAsteroidFlashlight;
    inherit qmlAsteroid;
    description = "AsteroidOS flashlight app";
    homepage = "https://github.com/AsteroidOS/asteroid-flashlight";
  };
  "asteroid-music" = pkgs.callPackage ../../../overlay/asteroidos/asteroid-qml-app {
    pname = "asteroid-music";
    src = asteroidosAsteroidMusic;
    inherit qmlAsteroid;
    description = "AsteroidOS music app";
    homepage = "https://github.com/AsteroidOS/asteroid-music";
  };
  "asteroid-stopwatch" = pkgs.callPackage ../../../overlay/asteroidos/asteroid-qml-app {
    pname = "asteroid-stopwatch";
    src = asteroidosAsteroidStopwatch;
    inherit qmlAsteroid;
    description = "AsteroidOS stopwatch app";
    homepage = "https://github.com/AsteroidOS/asteroid-stopwatch";
  };
  "asteroid-timer" = pkgs.callPackage ../../../overlay/asteroidos/asteroid-qml-app {
    pname = "asteroid-timer";
    src = asteroidosAsteroidTimer;
    inherit qmlAsteroid;
    description = "AsteroidOS timer app";
    homepage = "https://github.com/AsteroidOS/asteroid-timer";
  };
  "asteroid-weather" = pkgs.callPackage ../../../overlay/asteroidos/asteroid-qml-app {
    pname = "asteroid-weather";
    src = asteroidosAsteroidWeather;
    inherit qmlAsteroid;
    description = "AsteroidOS weather app";
    homepage = "https://github.com/AsteroidOS/asteroid-weather";
  };
}
