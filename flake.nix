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

    asteroidos-asteroid-launcher = {
      url = "github:AsteroidOS/asteroid-launcher";
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
  };

  outputs = {
    self,
    nixpkgs,
    asteroidos-meta-smartwatch,
    asteroidos-asteroid-launcher,
    asteroidos-qml-asteroid,
    asteroidos-lipstick,
    mer-hybris-bluebinder,
    mer-hybris-qt5-qpa-hwcomposer-plugin,
    fossil-kernel-msm-fossil-cw,
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
        (import ./overlay/overlay.nix final prev) // {
          # Expose AsteroidOS-related source inputs in pkgs for callPackage reuse.
          asteroidosMetaSmartwatch = asteroidos-meta-smartwatch;
          asteroidosAsteroidLauncher = asteroidos-asteroid-launcher;
          asteroidosQmlAsteroid = asteroidos-qml-asteroid;
          asteroidosLipstick = asteroidos-lipstick;
          merHybrisBluebinder = mer-hybris-bluebinder;
          merHybrisQt5QpaHwcomposerPlugin = mer-hybris-qt5-qpa-hwcomposer-plugin;
          fossilKernelMsmFossilCw = fossil-kernel-msm-fossil-cw;
        };

      # Non-flake source inputs exported for reuse in repo code.
      sources = {
        inherit
          asteroidos-meta-smartwatch
          asteroidos-asteroid-launcher
          asteroidos-qml-asteroid
          asteroidos-lipstick
          mer-hybris-bluebinder
          mer-hybris-qt5-qpa-hwcomposer-plugin
          fossil-kernel-msm-fossil-cw
        ;
      };

      # Expose evaluated sets as flake outputs.
      legacyPackages = forAllSystems ({ pkgs, ... }: {
        mobile = import ./legacy/default.nix { inherit pkgs; };
        examples = {
          hello = import ./examples/hello { inherit pkgs; };
          phosh = import ./examples/phosh { inherit pkgs; };
          plasma-mobile = import ./examples/plasma-mobile { inherit pkgs; };
          installer = import ./examples/installer { inherit pkgs; };
          hoki-asteroidos = import ./examples/hoki-asteroidos { inherit pkgs; };
        };

        # Keep source available in per-system package space for convenience.
        inherit
          asteroidos-meta-smartwatch
          asteroidos-asteroid-launcher
          asteroidos-qml-asteroid
          asteroidos-lipstick
          mer-hybris-bluebinder
          mer-hybris-qt5-qpa-hwcomposer-plugin
          fossil-kernel-msm-fossil-cw
        ;
      });

      devShells = forAllSystems ({ pkgs, ... }: {
        default = import ./legacy/shell.nix { inherit pkgs; };
      });
    };
}
