{
  stdenvNoCC,
  fetchFromGitHub,
  droidianAdaptationLenovoBronco ? null,
}:

let
  adaptationSrc =
    if droidianAdaptationLenovoBronco != null then
      droidianAdaptationLenovoBronco
    else
      fetchFromGitHub {
        owner = "droidian-devices";
        repo = "adaptation-droidian-bronco";
        rev = "cae81c1df119595ce340a25c39ca42a31a162086";
        hash = "sha256-GD0yJnKXBhwYI4rwlxxq4XhtdR61Jo+FcYm+haC+odQ=";
      };
in

stdenvNoCC.mkDerivation {
  pname = "lenovo-bronco-adaptation";
  version = "unstable";
  src = adaptationSrc;

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -vr etc $out/
    cp -vr usr $out/

    runHook postInstall
  '';
}
