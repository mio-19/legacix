{ pkgs ? null }: 

if pkgs == null then (builtins.throw "The `pkgs` argument needs to be provided to release-tools.nix") else
let
  # Original `evalConfig`
  evalConfig = import "${toString pkgs.path}/nixos/lib/eval-config.nix";
in
rec {
  # This should *never* rely on lib or pkgs.
  all-devices =
    builtins.filter
    (d: builtins.pathExists (../. + "/devices/${d}/default.nix"))
    (builtins.attrNames (builtins.readDir ../devices))
  ;

  # Evaluates NixOS, mobile-nixos and the device config with the given
  # additional modules.
  # Note that we can receive a "special" configuration, used internally by
  # `release.nix` and not part of the public API.
  evalWith =
    { modules
    , device
    , additionalConfiguration ? {}
    , baseModules ? (
      (import ../modules/module-list.nix)
      ++ (import "${toString pkgs.path}/nixos/modules/module-list.nix")
    )
  }: evalConfig {
    # Required for pure flake eval where builtins.currentSystem is unavailable.
    system = pkgs.stdenv.hostPlatform.system;
    inherit baseModules;
    specialArgs = {
      asteroidosMetaSmartwatch =
        if pkgs ? asteroidosMetaSmartwatch then pkgs.asteroidosMetaSmartwatch else null;
      asteroidosAsteroidLauncher =
        if pkgs ? asteroidosAsteroidLauncher then pkgs.asteroidosAsteroidLauncher else null;
      asteroidosQmlAsteroid =
        if pkgs ? asteroidosQmlAsteroid then pkgs.asteroidosQmlAsteroid else null;
      asteroidosLipstick =
        if pkgs ? asteroidosLipstick then pkgs.asteroidosLipstick else null;
      merHybrisBluebinder =
        if pkgs ? merHybrisBluebinder then pkgs.merHybrisBluebinder else null;
      merHybrisQt5QpaHwcomposerPlugin =
        if pkgs ? merHybrisQt5QpaHwcomposerPlugin then pkgs.merHybrisQt5QpaHwcomposerPlugin else null;
      fossilKernelMsmFossilCw =
        if pkgs ? fossilKernelMsmFossilCw then pkgs.fossilKernelMsmFossilCw else null;
    };
    modules =
      (if device ? special
      then [ device.config ]
      else if builtins.isPath device then [ { imports = [ device ]; } ]
      else [ { imports = [(../. + "/devices/${device}")]; } ])
      ++ modules
      ++ [ additionalConfiguration ]
    ;
  };

  # These can rely freely on lib, avoid depending on pkgs.
  withPkgs = pkgs:
    let
      inherit (pkgs) lib;
    in
    rec {
      specialConfig = {name, buildingForSystem, system, config ? {}}: {
        special = true;
        inherit name;
        config = lib.mkMerge [
          config
          {
            mobile.system.type = "none";
            mobile.hardware.soc = {
              x86_64-linux = "generic-x86_64";
              aarch64-linux = "generic-aarch64";
              armv7l-linux = "generic-armv7l";
            }.${buildingForSystem};
            nixpkgs.localSystem = knownSystems.${system};
          }
        ];
      };

      # Shortcuts from a simple system name to the structure required for
      # localSystem and crossSystem
      knownSystems = {
        x86_64-linux  = lib.systems.examples.gnu64;
        aarch64-linux = lib.systems.examples.aarch64-multiplatform;
        armv7l-linux  = lib.systems.examples.armv7l-hf-multiplatform;
      };

      # Eval with a configuration, for the given device.
      evalWithConfiguration = configuration: device: evalWith {
        modules = [ configuration ];
        inherit device;
      };

      # The simplest eval for a device, with an empty configuration.
      evalFor = evalWithConfiguration {};
    };
}
