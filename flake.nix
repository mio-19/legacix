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
  };

  outputs = {
    self,
    nixpkgs,
    asteroidos-meta-smartwatch,
    asteroidos-meta-asteroid,
    asteroidos-asteroid-launcher,
    asteroidos-asteroid-hrm,
    asteroidos-asteroid-compass,
    asteroidos-qml-asteroid,
    asteroidos-lipstick,
    mer-hybris-bluebinder,
    mer-hybris-qt5-qpa-hwcomposer-plugin,
    fossil-kernel-msm-fossil-cw,
    droidian-kernel-lenovo-bronco,
    droidian-adaptation-lenovo-bronco,
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
          asteroidosQmlAsteroid = asteroidos-qml-asteroid;
          asteroidosLipstick = asteroidos-lipstick;
          merHybrisBluebinder = mer-hybris-bluebinder;
          merHybrisQt5QpaHwcomposerPlugin = mer-hybris-qt5-qpa-hwcomposer-plugin;
          fossilKernelMsmFossilCw = fossil-kernel-msm-fossil-cw;
          droidianKernelLenovoBronco = droidian-kernel-lenovo-bronco;
          droidianAdaptationLenovoBronco = droidian-adaptation-lenovo-bronco;
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
          asteroidos-qml-asteroid
          asteroidos-lipstick
          mer-hybris-bluebinder
          mer-hybris-qt5-qpa-hwcomposer-plugin
          fossil-kernel-msm-fossil-cw
          droidian-kernel-lenovo-bronco
          droidian-adaptation-lenovo-bronco
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
          asteroidos-qml-asteroid
          asteroidos-lipstick
          mer-hybris-bluebinder
          mer-hybris-qt5-qpa-hwcomposer-plugin
          fossil-kernel-msm-fossil-cw
          droidian-kernel-lenovo-bronco
          droidian-adaptation-lenovo-bronco
        ;
      });

      devShells = forAllSystems ({ pkgs, ... }: {
        default = import ./legacy/shell.nix { inherit pkgs; };
      });
    };
}
