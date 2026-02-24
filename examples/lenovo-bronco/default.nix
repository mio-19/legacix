{ pkgs }:

import ../../lib/eval-with-configuration.nix {
  inherit pkgs;
  device = "lenovo-bronco";
  configuration = [ ];
  additionalHelpInstructions = ''
    Build Lenovo ThinkPhone (bronco) images:

      $ nix-build examples/lenovo-bronco -A outputs.default
  '';
}
