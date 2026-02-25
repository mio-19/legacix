{
  description = "legacix - legacy Android vendor-device focused Mobile NixOS fork";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-compat = {
      url = "github:NixOS/flake-compat";
      flake = false;
    };

    asteroidos-meta-smartwatch = {
      url = "github:AsteroidOS/meta-smartwatch";
      flake = false;
    };

    asteroidos-meta-asteroid = {
      url = "github:AsteroidOS/meta-asteroid";
      flake = false;
    };

    asteroidos-asteroid-launcher = {
      url = "github:AsteroidOS/asteroid-launcher";
      flake = false;
    };

    asteroidos-asteroid-hrm = {
      url = "git+https://github.com/AsteroidOS/asteroid-hrm.git?ref=master";
      flake = false;
    };

    asteroidos-asteroid-compass = {
      url = "git+https://github.com/AsteroidOS/asteroid-compass.git?ref=master";
      flake = false;
    };

    asteroidos-asteroid-calculator = {
      url = "github:AsteroidOS/asteroid-calculator";
      flake = false;
    };

    asteroidos-asteroid-calendar = {
      url = "github:AsteroidOS/asteroid-calendar";
      flake = false;
    };

    asteroidos-asteroid-diamonds = {
      url = "github:AsteroidOS/asteroid-diamonds";
      flake = false;
    };

    asteroidos-asteroid-flashlight = {
      url = "github:AsteroidOS/asteroid-flashlight";
      flake = false;
    };

    asteroidos-asteroid-music = {
      url = "github:AsteroidOS/asteroid-music";
      flake = false;
    };

    asteroidos-asteroid-stopwatch = {
      url = "github:AsteroidOS/asteroid-stopwatch";
      flake = false;
    };

    asteroidos-asteroid-timer = {
      url = "github:AsteroidOS/asteroid-timer";
      flake = false;
    };

    asteroidos-asteroid-weather = {
      url = "github:AsteroidOS/asteroid-weather";
      flake = false;
    };

    asteroidos-qml-asteroid = {
      url = "github:AsteroidOS/qml-asteroid";
      flake = false;
    };

    asteroidos-lipstick = {
      url = "github:AsteroidOS/lipstick";
      flake = false;
    };

    mer-hybris-bluebinder = {
      url = "github:mer-hybris/bluebinder";
      flake = false;
    };

    mer-hybris-qt5-qpa-hwcomposer-plugin = {
      url = "github:mer-hybris/qt5-qpa-hwcomposer-plugin";
      flake = false;
    };

    fossil-kernel-msm-fossil-cw = {
      url = "github:fossil-engineering/kernel-msm-fossil-cw?ref=fossil-android-msm-hoki-lw1.2-4.14";
      flake = false;
    };

    droidian-kernel-lenovo-bronco = {
      url = "github:droidian-devices/linux-android-lenovo-bronco";
      flake = false;
    };

    droidian-adaptation-lenovo-bronco = {
      url = "github:droidian-devices/adaptation-droidian-bronco";
      flake = false;
    };

    postmarketos-pmaports = {
      url = "git+https://gitlab.postmarketos.org/postmarketOS/pmaports.git";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    asteroidos-meta-smartwatch,
    asteroidos-meta-asteroid,
    asteroidos-asteroid-launcher,
    asteroidos-asteroid-hrm,
    asteroidos-asteroid-compass,
    asteroidos-asteroid-calculator,
    asteroidos-asteroid-calendar,
    asteroidos-asteroid-diamonds,
    asteroidos-asteroid-flashlight,
    asteroidos-asteroid-music,
    asteroidos-asteroid-stopwatch,
    asteroidos-asteroid-timer,
    asteroidos-asteroid-weather,
    asteroidos-qml-asteroid,
    asteroidos-lipstick,
    mer-hybris-bluebinder,
    mer-hybris-qt5-qpa-hwcomposer-plugin,
    fossil-kernel-msm-fossil-cw,
    droidian-kernel-lenovo-bronco,
    droidian-adaptation-lenovo-bronco,
    postmarketos-pmaports,
    ...
  }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

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
          # Expose AsteroidOS-related source inputs in pkgs for callPackage reuse.
          asteroidosMetaSmartwatch = asteroidos-meta-smartwatch;
          asteroidosMetaAsteroid = asteroidos-meta-asteroid;
          asteroidosAsteroidLauncher = asteroidos-asteroid-launcher;
          asteroidosAsteroidHrm = asteroidos-asteroid-hrm;
          asteroidosAsteroidCompass = asteroidos-asteroid-compass;
          asteroidosAsteroidCalculator = asteroidos-asteroid-calculator;
          asteroidosAsteroidCalendar = asteroidos-asteroid-calendar;
          asteroidosAsteroidDiamonds = asteroidos-asteroid-diamonds;
          asteroidosAsteroidFlashlight = asteroidos-asteroid-flashlight;
          asteroidosAsteroidMusic = asteroidos-asteroid-music;
          asteroidosAsteroidStopwatch = asteroidos-asteroid-stopwatch;
          asteroidosAsteroidTimer = asteroidos-asteroid-timer;
          asteroidosAsteroidWeather = asteroidos-asteroid-weather;
          asteroidosQmlAsteroid = asteroidos-qml-asteroid;
          asteroidosLipstick = asteroidos-lipstick;
          merHybrisBluebinder = mer-hybris-bluebinder;
          merHybrisQt5QpaHwcomposerPlugin = mer-hybris-qt5-qpa-hwcomposer-plugin;
          fossilKernelMsmFossilCw = fossil-kernel-msm-fossil-cw;
          droidianKernelLenovoBronco = droidian-kernel-lenovo-bronco;
          droidianAdaptationLenovoBronco = droidian-adaptation-lenovo-bronco;
          postmarketosPmaports = postmarketos-pmaports;
          asteroidos =
            let
              qmlAsteroidPkg = final.callPackage ./overlay/asteroidos/qml-asteroid {
                asteroidosQmlAsteroid = asteroidos-qml-asteroid;
              };
            in {
            qml-asteroid = qmlAsteroidPkg;
            asteroid-hrm = final.callPackage ./overlay/asteroidos/asteroid-hrm {
              asteroidosAsteroidHrm = asteroidos-asteroid-hrm;
              qmlAsteroid = qmlAsteroidPkg;
            };
            asteroid-compass = final.callPackage ./overlay/asteroidos/asteroid-compass {
              asteroidosAsteroidCompass = asteroidos-asteroid-compass;
              qmlAsteroid = qmlAsteroidPkg;
            };
            asteroid-calculator = final.callPackage ./overlay/asteroidos/asteroid-qml-app {
              pname = "asteroid-calculator";
              src = asteroidos-asteroid-calculator;
              qmlAsteroid = qmlAsteroidPkg;
              description = "AsteroidOS calculator app";
              homepage = "https://github.com/AsteroidOS/asteroid-calculator";
            };
            asteroid-calendar = final.callPackage ./overlay/asteroidos/asteroid-qml-app {
              pname = "asteroid-calendar";
              src = asteroidos-asteroid-calendar;
              qmlAsteroid = qmlAsteroidPkg;
              description = "AsteroidOS calendar app";
              homepage = "https://github.com/AsteroidOS/asteroid-calendar";
            };
            asteroid-diamonds = final.callPackage ./overlay/asteroidos/asteroid-qml-app {
              pname = "asteroid-diamonds";
              src = asteroidos-asteroid-diamonds;
              qmlAsteroid = qmlAsteroidPkg;
              description = "AsteroidOS diamonds game";
              homepage = "https://github.com/AsteroidOS/asteroid-diamonds";
            };
            asteroid-flashlight = final.callPackage ./overlay/asteroidos/asteroid-qml-app {
              pname = "asteroid-flashlight";
              src = asteroidos-asteroid-flashlight;
              qmlAsteroid = qmlAsteroidPkg;
              description = "AsteroidOS flashlight app";
              homepage = "https://github.com/AsteroidOS/asteroid-flashlight";
            };
            asteroid-music = final.callPackage ./overlay/asteroidos/asteroid-qml-app {
              pname = "asteroid-music";
              src = asteroidos-asteroid-music;
              qmlAsteroid = qmlAsteroidPkg;
              description = "AsteroidOS music app";
              homepage = "https://github.com/AsteroidOS/asteroid-music";
            };
            asteroid-stopwatch = final.callPackage ./overlay/asteroidos/asteroid-qml-app {
              pname = "asteroid-stopwatch";
              src = asteroidos-asteroid-stopwatch;
              qmlAsteroid = qmlAsteroidPkg;
              description = "AsteroidOS stopwatch app";
              homepage = "https://github.com/AsteroidOS/asteroid-stopwatch";
            };
            asteroid-timer = final.callPackage ./overlay/asteroidos/asteroid-qml-app {
              pname = "asteroid-timer";
              src = asteroidos-asteroid-timer;
              qmlAsteroid = qmlAsteroidPkg;
              description = "AsteroidOS timer app";
              homepage = "https://github.com/AsteroidOS/asteroid-timer";
            };
            asteroid-weather = final.callPackage ./overlay/asteroidos/asteroid-qml-app {
              pname = "asteroid-weather";
              src = asteroidos-asteroid-weather;
              qmlAsteroid = qmlAsteroidPkg;
              description = "AsteroidOS weather app";
              homepage = "https://github.com/AsteroidOS/asteroid-weather";
            };
            bluebinder = final.callPackage ./overlay/asteroidos/bluebinder {
              merHybrisBluebinder = mer-hybris-bluebinder;
            };
            "qt5-qpa-hwcomposer-plugin" = final.callPackage ./overlay/asteroidos/qt5-qpa-hwcomposer-plugin {
              merHybrisQt5QpaHwcomposerPlugin = mer-hybris-qt5-qpa-hwcomposer-plugin;
            };
            hoki-launcher-config = final.callPackage ./overlay/asteroidos/hoki-launcher-config {
              asteroidosMetaSmartwatch = asteroidos-meta-smartwatch;
            };
            hoki-underclock = final.callPackage ./overlay/asteroidos/hoki-underclock {
              asteroidosMetaSmartwatch = asteroidos-meta-smartwatch;
            };
            "android-init-hoki" = final.callPackage ./overlay/asteroidos/android-init-hoki {
              asteroidosMetaSmartwatch = asteroidos-meta-smartwatch;
              asteroidosMetaAsteroid = asteroidos-meta-asteroid;
            };
            "udev-droid-system" = final.callPackage ./overlay/asteroidos/udev-droid-system {
              asteroidosMetaAsteroid = asteroidos-meta-asteroid;
            };
            "swclock-offset" = final.callPackage ./overlay/asteroidos/swclock-offset { };
            "hoki-ngfd-config" = final.callPackage ./overlay/asteroidos/hoki-ngfd-config {
              asteroidosMetaSmartwatch = asteroidos-meta-smartwatch;
            };
            "hoki-libncicore-config" = final.callPackage ./overlay/asteroidos/hoki-libncicore-config {
              asteroidosMetaSmartwatch = asteroidos-meta-smartwatch;
            };
          };
        };

      # Non-flake source inputs exported for reuse in repo code.
      sources = {
        inherit
          asteroidos-meta-smartwatch
          asteroidos-meta-asteroid
          asteroidos-asteroid-launcher
          asteroidos-asteroid-hrm
          asteroidos-asteroid-compass
          asteroidos-asteroid-calculator
          asteroidos-asteroid-calendar
          asteroidos-asteroid-diamonds
          asteroidos-asteroid-flashlight
          asteroidos-asteroid-music
          asteroidos-asteroid-stopwatch
          asteroidos-asteroid-timer
          asteroidos-asteroid-weather
          asteroidos-qml-asteroid
          asteroidos-lipstick
          mer-hybris-bluebinder
          mer-hybris-qt5-qpa-hwcomposer-plugin
          fossil-kernel-msm-fossil-cw
          droidian-kernel-lenovo-bronco
          droidian-adaptation-lenovo-bronco
          postmarketos-pmaports
        ;
      };

      # Expose evaluated sets as flake outputs.
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

        # Keep source available in per-system package space for convenience.
        inherit
          asteroidos-meta-smartwatch
          asteroidos-meta-asteroid
          asteroidos-asteroid-launcher
          asteroidos-asteroid-hrm
          asteroidos-asteroid-compass
          asteroidos-asteroid-calculator
          asteroidos-asteroid-calendar
          asteroidos-asteroid-diamonds
          asteroidos-asteroid-flashlight
          asteroidos-asteroid-music
          asteroidos-asteroid-stopwatch
          asteroidos-asteroid-timer
          asteroidos-asteroid-weather
          asteroidos-qml-asteroid
          asteroidos-lipstick
          mer-hybris-bluebinder
          mer-hybris-qt5-qpa-hwcomposer-plugin
          fossil-kernel-msm-fossil-cw
          droidian-kernel-lenovo-bronco
          droidian-adaptation-lenovo-bronco
          postmarketos-pmaports
        ;
      });

      devShells = forAllSystems ({ pkgs, ... }: {
        default = import ./legacy/shell.nix { inherit pkgs; };
      });
    };
}
