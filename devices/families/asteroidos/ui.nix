{ pkgs, asteroidosPackages, ... }:
{
  environment.systemPackages = [
    asteroidosPackages.qml-asteroid
    asteroidosPackages."asteroid-hrm"
    asteroidosPackages."asteroid-compass"
    asteroidosPackages."asteroid-calculator"
    asteroidosPackages."asteroid-calendar"
    asteroidosPackages."asteroid-diamonds"
    asteroidosPackages."asteroid-flashlight"
    asteroidosPackages."asteroid-music"
    asteroidosPackages."asteroid-stopwatch"
    asteroidosPackages."asteroid-timer"
    asteroidosPackages."asteroid-weather"
    pkgs.connman
    pkgs.ofono
    pkgs.geoclue2
    pkgs.pulseaudio
  ];
}
