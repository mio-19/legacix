{ pkgs }:

import ../../lib/eval-with-configuration.nix {
  inherit pkgs;
  device = "hoki";
  configuration = [
    ({ config, pkgs, lib, ... }:
      let
        rootfs = config.mobile.outputs.generatedFilesystems.rootfs;
        bootimg = config.mobile.outputs.android.android-bootimg;
      in {
        # Keep the image profile minimal so iteration focuses on device bits.
        documentation.enable = false;
        documentation.nixos.enable = false;
        documentation.man.enable = false;
        documentation.doc.enable = false;
        documentation.info.enable = false;
        environment.defaultPackages = lib.mkForce [];
        programs.command-not-found.enable = false;
        security.sudo.enable = false;
        services.udisks2.enable = false;
        system.disableInstallerTools = true;

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
  additionalConfiguration = {};
}
