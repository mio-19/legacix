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
          sources = sourceInputs;
        in
        base // sources // {
          inherit sources;
          asteroidos =
            let
              qmlAsteroidPkg = final.callPackage ./overlay/asteroidos/qml-asteroid {
                asteroidosQmlAsteroid = sources.asteroidosQmlAsteroid;
              };
            in {
              qml-asteroid = qmlAsteroidPkg;
              asteroid-hrm = final.callPackage ./overlay/asteroidos/asteroid-hrm {
                asteroidosAsteroidHrm = sources.asteroidosAsteroidHrm;
                qmlAsteroid = qmlAsteroidPkg;
              };
              asteroid-compass = final.callPackage ./overlay/asteroidos/asteroid-compass {
                asteroidosAsteroidCompass = sources.asteroidosAsteroidCompass;
                qmlAsteroid = qmlAsteroidPkg;
              };
              asteroid-calculator = final.callPackage ./overlay/asteroidos/asteroid-qml-app {
                pname = "asteroid-calculator";
                src = sources.asteroidosAsteroidCalculator;
                qmlAsteroid = qmlAsteroidPkg;
                description = "AsteroidOS calculator app";
                homepage = "https://github.com/AsteroidOS/asteroid-calculator";
              };
              asteroid-calendar = final.callPackage ./overlay/asteroidos/asteroid-qml-app {
                pname = "asteroid-calendar";
                src = sources.asteroidosAsteroidCalendar;
                qmlAsteroid = qmlAsteroidPkg;
                description = "AsteroidOS calendar app";
                homepage = "https://github.com/AsteroidOS/asteroid-calendar";
              };
              asteroid-diamonds = final.callPackage ./overlay/asteroidos/asteroid-qml-app {
                pname = "asteroid-diamonds";
                src = sources.asteroidosAsteroidDiamonds;
                qmlAsteroid = qmlAsteroidPkg;
                description = "AsteroidOS diamonds game";
                homepage = "https://github.com/AsteroidOS/asteroid-diamonds";
              };
              asteroid-flashlight = final.callPackage ./overlay/asteroidos/asteroid-qml-app {
                pname = "asteroid-flashlight";
                src = sources.asteroidosAsteroidFlashlight;
                qmlAsteroid = qmlAsteroidPkg;
                description = "AsteroidOS flashlight app";
                homepage = "https://github.com/AsteroidOS/asteroid-flashlight";
              };
              asteroid-music = final.callPackage ./overlay/asteroidos/asteroid-qml-app {
                pname = "asteroid-music";
                src = sources.asteroidosAsteroidMusic;
                qmlAsteroid = qmlAsteroidPkg;
                description = "AsteroidOS music app";
                homepage = "https://github.com/AsteroidOS/asteroid-music";
              };
              asteroid-stopwatch = final.callPackage ./overlay/asteroidos/asteroid-qml-app {
                pname = "asteroid-stopwatch";
                src = sources.asteroidosAsteroidStopwatch;
                qmlAsteroid = qmlAsteroidPkg;
                description = "AsteroidOS stopwatch app";
                homepage = "https://github.com/AsteroidOS/asteroid-stopwatch";
              };
              asteroid-timer = final.callPackage ./overlay/asteroidos/asteroid-qml-app {
                pname = "asteroid-timer";
                src = sources.asteroidosAsteroidTimer;
                qmlAsteroid = qmlAsteroidPkg;
                description = "AsteroidOS timer app";
                homepage = "https://github.com/AsteroidOS/asteroid-timer";
              };
              asteroid-weather = final.callPackage ./overlay/asteroidos/asteroid-qml-app {
                pname = "asteroid-weather";
                src = sources.asteroidosAsteroidWeather;
                qmlAsteroid = qmlAsteroidPkg;
                description = "AsteroidOS weather app";
                homepage = "https://github.com/AsteroidOS/asteroid-weather";
              };
              bluebinder = final.callPackage ./overlay/asteroidos/bluebinder {
                merHybrisBluebinder = sources.merHybrisBluebinder;
              };
              "qt5-qpa-hwcomposer-plugin" = final.callPackage ./overlay/asteroidos/qt5-qpa-hwcomposer-plugin {
                merHybrisQt5QpaHwcomposerPlugin = sources.merHybrisQt5QpaHwcomposerPlugin;
              };
              hoki-launcher-config = final.callPackage ./overlay/asteroidos/hoki-launcher-config {
                asteroidosMetaSmartwatch = sources.asteroidosMetaSmartwatch;
              };
              hoki-underclock = final.callPackage ./overlay/asteroidos/hoki-underclock {
                asteroidosMetaSmartwatch = sources.asteroidosMetaSmartwatch;
              };
              "android-init-hoki" = final.callPackage ./overlay/asteroidos/android-init-hoki {
                asteroidosMetaSmartwatch = sources.asteroidosMetaSmartwatch;
                asteroidosMetaAsteroid = sources.asteroidosMetaAsteroid;
              };
              "udev-droid-system" = final.callPackage ./overlay/asteroidos/udev-droid-system {
                asteroidosMetaAsteroid = sources.asteroidosMetaAsteroid;
              };
              "swclock-offset" = final.callPackage ./overlay/asteroidos/swclock-offset { };
              "hoki-ngfd-config" = final.callPackage ./overlay/asteroidos/hoki-ngfd-config {
                asteroidosMetaSmartwatch = sources.asteroidosMetaSmartwatch;
              };
              "hoki-libncicore-config" = final.callPackage ./overlay/asteroidos/hoki-libncicore-config {
                asteroidosMetaSmartwatch = sources.asteroidosMetaSmartwatch;
              };
            };
        };

      sources = import ./sources/generated.nix {
        inherit (pkgsForFetch) fetchgit fetchurl fetchFromGitHub dockerTools;
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
      } // sourceInputs);

      apps = forAllSystems ({ pkgs, ... }: {
        update-sources = {
          type = "app";
          program = toString (pkgs.writeShellScript "update-sources" ''
            set -euo pipefail
            exec ${pkgs.nvfetcher}/bin/nvfetcher -c ./nvfetcher.toml -o ./sources "$@"
          '');
        };
      });

      devShells = forAllSystems ({ pkgs, ... }: {
        default = (import ./legacy/shell.nix { inherit pkgs; }).overrideAttrs (old: {
          buildInputs = old.buildInputs ++ [ pkgs.nvfetcher ];
        });
      });
    };
}
