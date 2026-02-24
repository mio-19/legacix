{
  stdenvNoCC,
  droidianAdaptationLenovoBronco,
}:

stdenvNoCC.mkDerivation {
  pname = "lenovo-bronco-adaptation";
  version = "unstable";
  src = droidianAdaptationLenovoBronco;

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -vr etc $out/
    cp -vr usr $out/

    runHook postInstall
  '';
}
