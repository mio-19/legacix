{
  description = "legacix - legacy Android vendor-device focused Mobile NixOS fork";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-compat = {
      url = "github:NixOS/flake-compat";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      pkgsForFetch = import nixpkgs { system = "x86_64-linux"; };

      sourceInputs = import ./sources/default.nix {
        inherit (pkgsForFetch) fetchFromGitHub fetchgit;
      };

      forAllSystems = f:
        nixpkgs.lib.genAttrs systems (system:
          f {
            inherit system;
            pkgs = import nixpkgs {
              inherit system;
              overlays = [ self.overlays.default ];
            };
          });
    in {
      overlays.default = final: prev:
        let
          base = import ./overlay/overlay.nix final prev;
        in
        base // {
          asteroidosMetaSmartwatch = sourceInputs.asteroidosMetaSmartwatch;
          asteroidosMetaAsteroid = sourceInputs.asteroidosMetaAsteroid;
          asteroidosAsteroidLauncher = sourceInputs.asteroidosAsteroidLauncher;
          asteroidosAsteroidHrm = sourceInputs.asteroidosAsteroidHrm;
          asteroidosAsteroidCompass = sourceInputs.asteroidosAsteroidCompass;
          asteroidosAsteroidCalculator = sourceInputs.asteroidosAsteroidCalculator;
          asteroidosAsteroidCalendar = sourceInputs.asteroidosAsteroidCalendar;
          asteroidosAsteroidDiamonds = sourceInputs.asteroidosAsteroidDiamonds;
          asteroidosAsteroidFlashlight = sourceInputs.asteroidosAsteroidFlashlight;
          asteroidosAsteroidMusic = sourceInputs.asteroidosAsteroidMusic;
          asteroidosAsteroidStopwatch = sourceInputs.asteroidosAsteroidStopwatch;
          asteroidosAsteroidTimer = sourceInputs.asteroidosAsteroidTimer;
          asteroidosAsteroidWeather = sourceInputs.asteroidosAsteroidWeather;
          asteroidosQmlAsteroid = sourceInputs.asteroidosQmlAsteroid;
          asteroidosLipstick = sourceInputs.asteroidosLipstick;
          merHybrisBluebinder = sourceInputs.merHybrisBluebinder;
          merHybrisQt5QpaHwcomposerPlugin = sourceInputs.merHybrisQt5QpaHwcomposerPlugin;
          fossilKernelMsmFossilCw = sourceInputs.fossilKernelMsmFossilCw;
          droidianKernelLenovoBronco = sourceInputs.droidianKernelLenovoBronco;
          droidianAdaptationLenovoBronco = sourceInputs.droidianAdaptationLenovoBronco;
          postmarketosPmaports = sourceInputs.postmarketosPmaports;
          asteroidos =
            let
              qmlAsteroidPkg = final.callPackage ./overlay/asteroidos/qml-asteroid {
                asteroidosQmlAsteroid = sourceInputs.asteroidosQmlAsteroid;
              };
            in {
              qml-asteroid = qmlAsteroidPkg;
              asteroid-hrm = final.callPackage ./overlay/asteroidos/asteroid-hrm {
                asteroidosAsteroidHrm = sourceInputs.asteroidosAsteroidHrm;
                qmlAsteroid = qmlAsteroidPkg;
              };
              asteroid-compass = final.callPackage ./overlay/asteroidos/asteroid-compass {
                asteroidosAsteroidCompass = sourceInputs.asteroidosAsteroidCompass;
                qmlAsteroid = qmlAsteroidPkg;
              };
              asteroid-calculator = final.callPackage ./overlay/asteroidos/asteroid-qml-app {
                pname = "asteroid-calculator";
                src = sourceInputs.asteroidosAsteroidCalculator;
                qmlAsteroid = qmlAsteroidPkg;
                description = "AsteroidOS calculator app";
                homepage = "https://github.com/AsteroidOS/asteroid-calculator";
              };
              asteroid-calendar = final.callPackage ./overlay/asteroidos/asteroid-qml-app {
                pname = "asteroid-calendar";
                src = sourceInputs.asteroidosAsteroidCalendar;
                qmlAsteroid = qmlAsteroidPkg;
                description = "AsteroidOS calendar app";
                homepage = "https://github.com/AsteroidOS/asteroid-calendar";
              };
              asteroid-diamonds = final.callPackage ./overlay/asteroidos/asteroid-qml-app {
                pname = "asteroid-diamonds";
                src = sourceInputs.asteroidosAsteroidDiamonds;
                qmlAsteroid = qmlAsteroidPkg;
                description = "AsteroidOS diamonds game";
                homepage = "https://github.com/AsteroidOS/asteroid-diamonds";
              };
              asteroid-flashlight = final.callPackage ./overlay/asteroidos/asteroid-qml-app {
                pname = "asteroid-flashlight";
                src = sourceInputs.asteroidosAsteroidFlashlight;
                qmlAsteroid = qmlAsteroidPkg;
                description = "AsteroidOS flashlight app";
                homepage = "https://github.com/AsteroidOS/asteroid-flashlight";
              };
              asteroid-music = final.callPackage ./overlay/asteroidos/asteroid-qml-app {
                pname = "asteroid-music";
                src = sourceInputs.asteroidosAsteroidMusic;
                qmlAsteroid = qmlAsteroidPkg;
                description = "AsteroidOS music app";
                homepage = "https://github.com/AsteroidOS/asteroid-music";
              };
              asteroid-stopwatch = final.callPackage ./overlay/asteroidos/asteroid-qml-app {
                pname = "asteroid-stopwatch";
                src = sourceInputs.asteroidosAsteroidStopwatch;
                qmlAsteroid = qmlAsteroidPkg;
                description = "AsteroidOS stopwatch app";
                homepage = "https://github.com/AsteroidOS/asteroid-stopwatch";
              };
              asteroid-timer = final.callPackage ./overlay/asteroidos/asteroid-qml-app {
                pname = "asteroid-timer";
                src = sourceInputs.asteroidosAsteroidTimer;
                qmlAsteroid = qmlAsteroidPkg;
                description = "AsteroidOS timer app";
                homepage = "https://github.com/AsteroidOS/asteroid-timer";
              };
              asteroid-weather = final.callPackage ./overlay/asteroidos/asteroid-qml-app {
                pname = "asteroid-weather";
                src = sourceInputs.asteroidosAsteroidWeather;
                qmlAsteroid = qmlAsteroidPkg;
                description = "AsteroidOS weather app";
                homepage = "https://github.com/AsteroidOS/asteroid-weather";
              };
              bluebinder = final.callPackage ./overlay/asteroidos/bluebinder {
                merHybrisBluebinder = sourceInputs.merHybrisBluebinder;
              };
              "qt5-qpa-hwcomposer-plugin" = final.callPackage ./overlay/asteroidos/qt5-qpa-hwcomposer-plugin {
                merHybrisQt5QpaHwcomposerPlugin = sourceInputs.merHybrisQt5QpaHwcomposerPlugin;
              };
              hoki-launcher-config = final.callPackage ./overlay/asteroidos/hoki-launcher-config {
                asteroidosMetaSmartwatch = sourceInputs.asteroidosMetaSmartwatch;
              };
              hoki-underclock = final.callPackage ./overlay/asteroidos/hoki-underclock {
                asteroidosMetaSmartwatch = sourceInputs.asteroidosMetaSmartwatch;
              };
              "android-init-hoki" = final.callPackage ./overlay/asteroidos/android-init-hoki {
                asteroidosMetaSmartwatch = sourceInputs.asteroidosMetaSmartwatch;
                asteroidosMetaAsteroid = sourceInputs.asteroidosMetaAsteroid;
              };
              "udev-droid-system" = final.callPackage ./overlay/asteroidos/udev-droid-system {
                asteroidosMetaAsteroid = sourceInputs.asteroidosMetaAsteroid;
              };
              "swclock-offset" = final.callPackage ./overlay/asteroidos/swclock-offset { };
              "hoki-ngfd-config" = final.callPackage ./overlay/asteroidos/hoki-ngfd-config {
                asteroidosMetaSmartwatch = sourceInputs.asteroidosMetaSmartwatch;
              };
              "hoki-libncicore-config" = final.callPackage ./overlay/asteroidos/hoki-libncicore-config {
                asteroidosMetaSmartwatch = sourceInputs.asteroidosMetaSmartwatch;
              };
            };
        };

      sources = {
        asteroidos-meta-smartwatch = sourceInputs.asteroidosMetaSmartwatch;
        asteroidos-meta-asteroid = sourceInputs.asteroidosMetaAsteroid;
        asteroidos-asteroid-launcher = sourceInputs.asteroidosAsteroidLauncher;
        asteroidos-asteroid-hrm = sourceInputs.asteroidosAsteroidHrm;
        asteroidos-asteroid-compass = sourceInputs.asteroidosAsteroidCompass;
        asteroidos-asteroid-calculator = sourceInputs.asteroidosAsteroidCalculator;
        asteroidos-asteroid-calendar = sourceInputs.asteroidosAsteroidCalendar;
        asteroidos-asteroid-diamonds = sourceInputs.asteroidosAsteroidDiamonds;
        asteroidos-asteroid-flashlight = sourceInputs.asteroidosAsteroidFlashlight;
        asteroidos-asteroid-music = sourceInputs.asteroidosAsteroidMusic;
        asteroidos-asteroid-stopwatch = sourceInputs.asteroidosAsteroidStopwatch;
        asteroidos-asteroid-timer = sourceInputs.asteroidosAsteroidTimer;
        asteroidos-asteroid-weather = sourceInputs.asteroidosAsteroidWeather;
        asteroidos-qml-asteroid = sourceInputs.asteroidosQmlAsteroid;
        asteroidos-lipstick = sourceInputs.asteroidosLipstick;
        mer-hybris-bluebinder = sourceInputs.merHybrisBluebinder;
        mer-hybris-qt5-qpa-hwcomposer-plugin = sourceInputs.merHybrisQt5QpaHwcomposerPlugin;
        fossil-kernel-msm-fossil-cw = sourceInputs.fossilKernelMsmFossilCw;
        droidian-kernel-lenovo-bronco = sourceInputs.droidianKernelLenovoBronco;
        droidian-adaptation-lenovo-bronco = sourceInputs.droidianAdaptationLenovoBronco;
        postmarketos-pmaports = sourceInputs.postmarketosPmaports;
      };

      legacyPackages = forAllSystems ({ pkgs, ... }: {
        mobile = import ./legacy/default.nix {
          inherit pkgs;
          device = null;
          configuration = null;
        };
        examples = {
          hello = import ./examples/hello { inherit pkgs; device = null; };
          phosh = import ./examples/phosh { inherit pkgs; device = null; };
          plasma-mobile = import ./examples/plasma-mobile { inherit pkgs; device = null; };
          installer = import ./examples/installer { inherit pkgs; device = null; };
          hoki-asteroidos = import ./examples/hoki-asteroidos { inherit pkgs; };
          lenovo-bronco = import ./examples/lenovo-bronco { inherit pkgs; };
        };

        inherit (sourceInputs)
          asteroidosMetaSmartwatch
          asteroidosMetaAsteroid
          asteroidosAsteroidLauncher
          asteroidosAsteroidHrm
          asteroidosAsteroidCompass
          asteroidosAsteroidCalculator
          asteroidosAsteroidCalendar
          asteroidosAsteroidDiamonds
          asteroidosAsteroidFlashlight
          asteroidosAsteroidMusic
          asteroidosAsteroidStopwatch
          asteroidosAsteroidTimer
          asteroidosAsteroidWeather
          asteroidosQmlAsteroid
          asteroidosLipstick
          merHybrisBluebinder
          merHybrisQt5QpaHwcomposerPlugin
          fossilKernelMsmFossilCw
          droidianKernelLenovoBronco
          droidianAdaptationLenovoBronco
          postmarketosPmaports
        ;
      });

      devShells = forAllSystems ({ pkgs, ... }: {
        default = import ./legacy/shell.nix { inherit pkgs; };
      });
    };
}
