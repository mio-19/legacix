{ fetchFromGitHub, fetchgit }:
{
  asteroidosMetaSmartwatch = fetchFromGitHub {
    owner = "AsteroidOS";
    repo = "meta-smartwatch";
    rev = "3f8b55b48d286f36044b06eb2801ab53d7c490a5";
    hash = "sha256-9blQ1VWzNjYC+pPmUje4jflkCABR4Kmy6iHAQ03g7EA=";
  };

  asteroidosMetaAsteroid = fetchFromGitHub {
    owner = "AsteroidOS";
    repo = "meta-asteroid";
    rev = "71878ed09e43cef93a86512149199526ce5e4f3f";
    hash = "sha256-0baPfC7YjNsp3Y+C7yjO6H/WxoR4bDv4KyrmT2/ezsU=";
  };

  asteroidosAsteroidLauncher = fetchFromGitHub {
    owner = "AsteroidOS";
    repo = "asteroid-launcher";
    rev = "1adc829168508e23f5b9267024b9cc1043f2cd3e";
    hash = "sha256-ISgTZCZQ71VpqklDbbMvkJUqZqo4g/CZYHdzqkLHbCE=";
  };

  asteroidosAsteroidHrm = fetchgit {
    url = "https://github.com/AsteroidOS/asteroid-hrm.git";
    rev = "f825486c1c9a8038a97e7689ad4c34a7156c5cb9";
    hash = "sha256-v4GYnB68P+y0Bcb5Y7griLInCArP5PEFY6Q3MjDwx7Y=";
  };

  asteroidosAsteroidCompass = fetchgit {
    url = "https://github.com/AsteroidOS/asteroid-compass.git";
    rev = "b7d890885b3b3310741ab605b564f88fb076544b";
    hash = "sha256-XIHkdm3B+5V3ccEf6AYA2oUflTU5If6fJCi8JceeW7s=";
  };

  asteroidosAsteroidCalculator = fetchFromGitHub {
    owner = "AsteroidOS";
    repo = "asteroid-calculator";
    rev = "dd2b9b93afc153c617e81e6ad77caca9162392fb";
    hash = "sha256-ZxcQJF69T0RkB3USAKKmcY8dIHSdQlCVFy7YLIprI3Q=";
  };

  asteroidosAsteroidCalendar = fetchFromGitHub {
    owner = "AsteroidOS";
    repo = "asteroid-calendar";
    rev = "8255fbf79fffd9c7be57933b8e67fd76ede22d90";
    hash = "sha256-+6ojLUhTnE3oZ7RSnPqjK7i4nCauLuzqAFunJZmZJI8=";
  };

  asteroidosAsteroidDiamonds = fetchFromGitHub {
    owner = "AsteroidOS";
    repo = "asteroid-diamonds";
    rev = "2c587a088992ab3f04b3c643219c1735b2d1bb98";
    hash = "sha256-urkJvFA/1UzYqJcdX7xGPUFQgvhyB8/AhEarDxjJg6E=";
  };

  asteroidosAsteroidFlashlight = fetchFromGitHub {
    owner = "AsteroidOS";
    repo = "asteroid-flashlight";
    rev = "cd106ae07b9afadca712ae34a3ba8edd1a8f5148";
    hash = "sha256-Fc5DrefBTQ03CCd3cUNvEjkyR7p5DVKq4upXdWxt66c=";
  };

  asteroidosAsteroidMusic = fetchFromGitHub {
    owner = "AsteroidOS";
    repo = "asteroid-music";
    rev = "b86aa04d8db45852aa1804306f3123baf0bfd441";
    hash = "sha256-dzmBlj1hrp6wFFZPsG+j6P/GxBqlq2Dh3/h84tv57LE=";
  };

  asteroidosAsteroidStopwatch = fetchFromGitHub {
    owner = "AsteroidOS";
    repo = "asteroid-stopwatch";
    rev = "9c63021c9ebd5887a880954014a6d31545dceaaf";
    hash = "sha256-1Tx18wWwLji8jP8e7JqWsX1RwcsfhkzVCG/MEtSKOX0=";
  };

  asteroidosAsteroidTimer = fetchFromGitHub {
    owner = "AsteroidOS";
    repo = "asteroid-timer";
    rev = "f04baa1e99fd867fab9c83b84412def455a1266f";
    hash = "sha256-sgOXFXPxapUUHxiiUildZGkA28Co/zZRPZJy+qb+9Jw=";
  };

  asteroidosAsteroidWeather = fetchFromGitHub {
    owner = "AsteroidOS";
    repo = "asteroid-weather";
    rev = "827d1c4b5d662977d311168853f2b02e946f9841";
    hash = "sha256-dFYtcUv/6dmq7Bg0e+6CGH/5a/Ct93/271kFN5zZFTs=";
  };

  asteroidosQmlAsteroid = fetchFromGitHub {
    owner = "AsteroidOS";
    repo = "qml-asteroid";
    rev = "40a1d8befb61ac7066e4ee885f49393f2ec0d377";
    hash = "sha256-OYmp98UE88wnJ/T9Od5q63pdP33bkqufNwgrcwieO0w=";
  };

  asteroidosLipstick = fetchFromGitHub {
    owner = "AsteroidOS";
    repo = "lipstick";
    rev = "ac2d4f0348e27c16c7f7eab3c03e265fc6466f0f";
    hash = "sha256-g+vD8qksUOoIAI+0vLNNM0VYyxuh/1gYsRDsG4WzllU=";
  };

  merHybrisBluebinder = fetchFromGitHub {
    owner = "mer-hybris";
    repo = "bluebinder";
    rev = "9c15cd87cd13e7176e805f959ee8602c491dd95a";
    hash = "sha256-UPn9vp21PKL+KEqDjssiScOA8D3QmSAve7Ktmf9tLIk=";
  };

  merHybrisQt5QpaHwcomposerPlugin = fetchFromGitHub {
    owner = "mer-hybris";
    repo = "qt5-qpa-hwcomposer-plugin";
    rev = "41e7bda3bc7a87a1cffd45d44bf6abef90460b38";
    hash = "sha256-hZOy8ws4/9QFyJrXljanR6az59E8efcSLFb63zWqNCQ=";
  };

  fossilKernelMsmFossilCw = fetchFromGitHub {
    owner = "fossil-engineering";
    repo = "kernel-msm-fossil-cw";
    rev = "c0b4c201f2d5a641defe19958a9b4c16f40d866b";
    hash = "sha256-uf5Vln2M64ksT9BC4/R9gLV2yo6zK0vQeolyCUj/u+o=";
  };

  droidianKernelLenovoBronco = fetchFromGitHub {
    owner = "droidian-devices";
    repo = "linux-android-lenovo-bronco";
    rev = "051a9a15805146d91fa833c25a65af018ef5671a";
    hash = "sha256-waLjUlm944WZAuODfji8sJBdnIzPTraCNxozORl4hd8=";
  };

  droidianAdaptationLenovoBronco = fetchFromGitHub {
    owner = "droidian-devices";
    repo = "adaptation-droidian-bronco";
    rev = "cae81c1df119595ce340a25c39ca42a31a162086";
    hash = "sha256-GD0yJnKXBhwYI4rwlxxq4XhtdR61Jo+FcYm+haC+odQ=";
  };

  postmarketosPmaports = fetchgit {
    url = "https://gitlab.postmarketos.org/postmarketOS/pmaports.git";
    rev = "854721bdba8de52768989fa9579e392accb973d8";
    hash = "sha256-/pXOJGBUW/0qzmJG0PsRWW9Q/Fbe/NncAYgBVMNCLBg=";
  };
}
