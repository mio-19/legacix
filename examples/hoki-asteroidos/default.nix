{ pkgs ? (import ../../pkgs.nix {}) }:

import ../../lib/eval-with-configuration.nix {
  inherit pkgs;
  device = "hoki";
  configuration = [
    ({ config, pkgs, lib, ... }:
      let
        rootfs = config.mobile.outputs.generatedFilesystems.rootfs;
        bootimg = config.mobile.outputs.android.android-bootimg;
      in {
        mobile.outputs.default = lib.mkForce (pkgs.runCommand "asteroidos-hoki-images" {} ''
          mkdir -p "$out"
          cp -v ${rootfs}/${rootfs.filename} "$out/asteroidos.ext4"
          cp -v ${bootimg} "$out/boot.img"
        '');
      })
  ];
  additionalHelpInstructions = ''
    Build AsteroidOS-style hoki images:

      $ nix-build examples/hoki-asteroidos -A outputs.default

    This produces two files in one output directory:
      - asteroidos.ext4
      - boot.img
  '';
}
