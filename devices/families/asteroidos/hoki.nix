{ pkgs, asteroidosPackages, ... }:
{
  environment.systemPackages = [
    asteroidosPackages.hoki-underclock
    asteroidosPackages."hoki-launcher-config"
    asteroidosPackages."hoki-libncicore-config"
    asteroidosPackages."hoki-ngfd-config"
  ];

  environment.etc = {
    "default/asteroid-launcher".source = "${asteroidosPackages."hoki-launcher-config"}/etc/default/asteroid-launcher";
    "libncicore.conf".source = "${asteroidosPackages."hoki-libncicore-config"}/etc/libncicore.conf";
    "ngfd/plugins.d/51-ffmemless.ini".source = "${asteroidosPackages."hoki-ngfd-config"}/share/ngfd/plugins.d/51-ffmemless.ini";
    "android-init/plat_property_contexts".source = "${asteroidosPackages."android-init-hoki"}/etc/android-init/plat_property_contexts";
    "android-init/nonplat_property_contexts".source = "${asteroidosPackages."android-init-hoki"}/etc/android-init/nonplat_property_contexts";
    "android-init/init.rc".source = "${asteroidosPackages."android-init-hoki"}/init.rc";
  };

  systemd.services.underclock = {
    description = "Underclock CPU/GPU to reduce hoki power usage";
    wantedBy = [ "basic.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 20";
      ExecStart = "${asteroidosPackages.hoki-underclock}/bin/underclock";
    };
  };
}
