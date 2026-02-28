# This file is maintained by nvfetcher.
# Regenerate with: nix run .#update-sources
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  "asteroidos-meta-smartwatch" = {
    pname = "asteroidos-meta-smartwatch";
    version = "3f8b55b48d286f36044b06eb2801ab53d7c490a5";
    src = fetchgit {
      url = "https://github.com/AsteroidOS/meta-smartwatch.git";
      rev = "3f8b55b48d286f36044b06eb2801ab53d7c490a5";
      hash = "sha256-9blQ1VWzNjYC+pPmUje4jflkCABR4Kmy6iHAQ03g7EA=";
    };
  };

  "asteroidos-meta-asteroid" = {
    pname = "asteroidos-meta-asteroid";
    version = "71878ed09e43cef93a86512149199526ce5e4f3f";
    src = fetchgit {
      url = "https://github.com/AsteroidOS/meta-asteroid.git";
      rev = "71878ed09e43cef93a86512149199526ce5e4f3f";
      hash = "sha256-0baPfC7YjNsp3Y+C7yjO6H/WxoR4bDv4KyrmT2/ezsU=";
    };
  };

  "asteroidos-asteroid-launcher" = {
    pname = "asteroidos-asteroid-launcher";
    version = "1adc829168508e23f5b9267024b9cc1043f2cd3e";
    src = fetchgit {
      url = "https://github.com/AsteroidOS/asteroid-launcher.git";
      rev = "1adc829168508e23f5b9267024b9cc1043f2cd3e";
      hash = "sha256-ISgTZCZQ71VpqklDbbMvkJUqZqo4g/CZYHdzqkLHbCE=";
    };
  };

  "asteroidos-asteroid-hrm" = {
    pname = "asteroidos-asteroid-hrm";
    version = "f825486c1c9a8038a97e7689ad4c34a7156c5cb9";
    src = fetchgit {
      url = "https://github.com/AsteroidOS/asteroid-hrm.git";
      rev = "f825486c1c9a8038a97e7689ad4c34a7156c5cb9";
      hash = "sha256-v4GYnB68P+y0Bcb5Y7griLInCArP5PEFY6Q3MjDwx7Y=";
    };
  };

  "asteroidos-asteroid-compass" = {
    pname = "asteroidos-asteroid-compass";
    version = "b7d890885b3b3310741ab605b564f88fb076544b";
    src = fetchgit {
      url = "https://github.com/AsteroidOS/asteroid-compass.git";
      rev = "b7d890885b3b3310741ab605b564f88fb076544b";
      hash = "sha256-XIHkdm3B+5V3ccEf6AYA2oUflTU5If6fJCi8JceeW7s=";
    };
  };

  "asteroidos-asteroid-calculator" = {
    pname = "asteroidos-asteroid-calculator";
    version = "dd2b9b93afc153c617e81e6ad77caca9162392fb";
    src = fetchgit {
      url = "https://github.com/AsteroidOS/asteroid-calculator.git";
      rev = "dd2b9b93afc153c617e81e6ad77caca9162392fb";
      hash = "sha256-ZxcQJF69T0RkB3USAKKmcY8dIHSdQlCVFy7YLIprI3Q=";
    };
  };

  "asteroidos-asteroid-calendar" = {
    pname = "asteroidos-asteroid-calendar";
    version = "8255fbf79fffd9c7be57933b8e67fd76ede22d90";
    src = fetchgit {
      url = "https://github.com/AsteroidOS/asteroid-calendar.git";
      rev = "8255fbf79fffd9c7be57933b8e67fd76ede22d90";
      hash = "sha256-+6ojLUhTnE3oZ7RSnPqjK7i4nCauLuzqAFunJZmZJI8=";
    };
  };

  "asteroidos-asteroid-diamonds" = {
    pname = "asteroidos-asteroid-diamonds";
    version = "2c587a088992ab3f04b3c643219c1735b2d1bb98";
    src = fetchgit {
      url = "https://github.com/AsteroidOS/asteroid-diamonds.git";
      rev = "2c587a088992ab3f04b3c643219c1735b2d1bb98";
      hash = "sha256-urkJvFA/1UzYqJcdX7xGPUFQgvhyB8/AhEarDxjJg6E=";
    };
  };

  "asteroidos-asteroid-flashlight" = {
    pname = "asteroidos-asteroid-flashlight";
    version = "cd106ae07b9afadca712ae34a3ba8edd1a8f5148";
    src = fetchgit {
      url = "https://github.com/AsteroidOS/asteroid-flashlight.git";
      rev = "cd106ae07b9afadca712ae34a3ba8edd1a8f5148";
      hash = "sha256-Fc5DrefBTQ03CCd3cUNvEjkyR7p5DVKq4upXdWxt66c=";
    };
  };

  "asteroidos-asteroid-music" = {
    pname = "asteroidos-asteroid-music";
    version = "b86aa04d8db45852aa1804306f3123baf0bfd441";
    src = fetchgit {
      url = "https://github.com/AsteroidOS/asteroid-music.git";
      rev = "b86aa04d8db45852aa1804306f3123baf0bfd441";
      hash = "sha256-dzmBlj1hrp6wFFZPsG+j6P/GxBqlq2Dh3/h84tv57LE=";
    };
  };

  "asteroidos-asteroid-stopwatch" = {
    pname = "asteroidos-asteroid-stopwatch";
    version = "9c63021c9ebd5887a880954014a6d31545dceaaf";
    src = fetchgit {
      url = "https://github.com/AsteroidOS/asteroid-stopwatch.git";
      rev = "9c63021c9ebd5887a880954014a6d31545dceaaf";
      hash = "sha256-1Tx18wWwLji8jP8e7JqWsX1RwcsfhkzVCG/MEtSKOX0=";
    };
  };

  "asteroidos-asteroid-timer" = {
    pname = "asteroidos-asteroid-timer";
    version = "f04baa1e99fd867fab9c83b84412def455a1266f";
    src = fetchgit {
      url = "https://github.com/AsteroidOS/asteroid-timer.git";
      rev = "f04baa1e99fd867fab9c83b84412def455a1266f";
      hash = "sha256-sgOXFXPxapUUHxiiUildZGkA28Co/zZRPZJy+qb+9Jw=";
    };
  };

  "asteroidos-asteroid-weather" = {
    pname = "asteroidos-asteroid-weather";
    version = "827d1c4b5d662977d311168853f2b02e946f9841";
    src = fetchgit {
      url = "https://github.com/AsteroidOS/asteroid-weather.git";
      rev = "827d1c4b5d662977d311168853f2b02e946f9841";
      hash = "sha256-dFYtcUv/6dmq7Bg0e+6CGH/5a/Ct93/271kFN5zZFTs=";
    };
  };

  "asteroidos-qml-asteroid" = {
    pname = "asteroidos-qml-asteroid";
    version = "40a1d8befb61ac7066e4ee885f49393f2ec0d377";
    src = fetchgit {
      url = "https://github.com/AsteroidOS/qml-asteroid.git";
      rev = "40a1d8befb61ac7066e4ee885f49393f2ec0d377";
      hash = "sha256-OYmp98UE88wnJ/T9Od5q63pdP33bkqufNwgrcwieO0w=";
    };
  };

  "asteroidos-lipstick" = {
    pname = "asteroidos-lipstick";
    version = "ac2d4f0348e27c16c7f7eab3c03e265fc6466f0f";
    src = fetchgit {
      url = "https://github.com/AsteroidOS/lipstick.git";
      rev = "ac2d4f0348e27c16c7f7eab3c03e265fc6466f0f";
      hash = "sha256-g+vD8qksUOoIAI+0vLNNM0VYyxuh/1gYsRDsG4WzllU=";
    };
  };

  "mer-hybris-bluebinder" = {
    pname = "mer-hybris-bluebinder";
    version = "9c15cd87cd13e7176e805f959ee8602c491dd95a";
    src = fetchgit {
      url = "https://github.com/mer-hybris/bluebinder.git";
      rev = "9c15cd87cd13e7176e805f959ee8602c491dd95a";
      hash = "sha256-UPn9vp21PKL+KEqDjssiScOA8D3QmSAve7Ktmf9tLIk=";
    };
  };

  "mer-hybris-qt5-qpa-hwcomposer-plugin" = {
    pname = "mer-hybris-qt5-qpa-hwcomposer-plugin";
    version = "41e7bda3bc7a87a1cffd45d44bf6abef90460b38";
    src = fetchgit {
      url = "https://github.com/mer-hybris/qt5-qpa-hwcomposer-plugin.git";
      rev = "41e7bda3bc7a87a1cffd45d44bf6abef90460b38";
      hash = "sha256-hZOy8ws4/9QFyJrXljanR6az59E8efcSLFb63zWqNCQ=";
    };
  };

  "fossil-kernel-msm-fossil-cw" = {
    pname = "fossil-kernel-msm-fossil-cw";
    version = "c0b4c201f2d5a641defe19958a9b4c16f40d866b";
    src = fetchgit {
      url = "https://github.com/fossil-engineering/kernel-msm-fossil-cw.git";
      rev = "c0b4c201f2d5a641defe19958a9b4c16f40d866b";
      hash = "sha256-uf5Vln2M64ksT9BC4/R9gLV2yo6zK0vQeolyCUj/u+o=";
    };
  };

  "droidian-kernel-lenovo-bronco" = {
    pname = "droidian-kernel-lenovo-bronco";
    version = "051a9a15805146d91fa833c25a65af018ef5671a";
    src = fetchgit {
      url = "https://github.com/droidian-devices/linux-android-lenovo-bronco.git";
      rev = "051a9a15805146d91fa833c25a65af018ef5671a";
      hash = "sha256-waLjUlm944WZAuODfji8sJBdnIzPTraCNxozORl4hd8=";
    };
  };

  "droidian-adaptation-lenovo-bronco" = {
    pname = "droidian-adaptation-lenovo-bronco";
    version = "cae81c1df119595ce340a25c39ca42a31a162086";
    src = fetchgit {
      url = "https://github.com/droidian-devices/adaptation-droidian-bronco.git";
      rev = "cae81c1df119595ce340a25c39ca42a31a162086";
      hash = "sha256-GD0yJnKXBhwYI4rwlxxq4XhtdR61Jo+FcYm+haC+odQ=";
    };
  };

  "postmarketos-pmaports" = {
    pname = "postmarketos-pmaports";
    version = "854721bdba8de52768989fa9579e392accb973d8";
    src = fetchgit {
      url = "https://gitlab.postmarketos.org/postmarketOS/pmaports.git";
      rev = "854721bdba8de52768989fa9579e392accb973d8";
      hash = "sha256-/pXOJGBUW/0qzmJG0PsRWW9Q/Fbe/NncAYgBVMNCLBg=";
    };
  };
}
