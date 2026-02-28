self: super:

let
  fetchpatch = self.fetchpatch;
  callPackage = self.callPackage;
  # FIXME : upstream fix for .a in "lib" instead of this hack.
  # This is used to "re-merge" the split gcc package.
  # Static libraries (.a) aren't available in the "lib" package.
  # libtool, reading the `.la` files in the "lib" package expects `.a`
  # to be in the "lib" package; they are in out.
  merged_gcc7 = super.wrapCC (self.symlinkJoin {
    name = "gcc7-merged";
    paths = with super.buildPackages.gcc7.cc; [ out lib ];
  });
in
  {
    # Misc. tools.
    # Keep sorted.
    adbd = callPackage ./adbd { };
    android-headers = callPackage ./android-headers { };
    dtbTool = callPackage ./dtbtool { };
    dtbTool-exynos = callPackage ./dtbtool-exynos { };
    libhybris = callPackage ./libhybris {
      # FIXME : verify how it acts on native aarch64 build.
      stdenv = if self.buildPlatform != self.targetPlatform then
        self.stdenv
      else
        with self; overrideCC stdenv (merged_gcc7)
      ;
    };
    mkbootimg = callPackage ./mkbootimg { };
    msm-fb-refresher = callPackage ./msm-fb-refresher { };
    ply-image = callPackage ./ply-image { };
    qc-image-unpacker = callPackage ./qc-image-unpacker { };
    ufdt-apply-overlay = callPackage ./ufdt-apply-overlay {};

    # Extra "libs"
    mkExtraUtils = import ./lib/extra-utils.nix {
      inherit (self)
        runCommandCC
        glibc
        buildPackages
      ;
      inherit (self.buildPackages)
        nukeReferences
      ;
    };

    #
    # New software to upstream
    # ------------------------
    #

    android-partition-tools = callPackage ./android-partition-tools {
      stdenv = with self; overrideCC stdenv buildPackages.clang_11;
    };
    make_ext4fs = callPackage ./make_ext4fs {};
    hardshutdown = callPackage ./hardshutdown {};
    bootlogd = callPackage ./bootlogd {};
    libusbgx = callPackage ./libusbgx {};
    gadget-tool = callPackage ./gt {}; # upstream this is called "gt", which is very Unix.
    libevdev = super.libevdev.overrideAttrs ({ nativeBuildInputs ? [], ... }: {
      nativeBuildInputs = nativeBuildInputs ++ [
        self.buildPackages.pkg-config
      ];
    });

    qrtr = callPackage ./qrtr/qrtr.nix { };
    qmic = callPackage ./qrtr/qmic.nix { };
    tqftpserv = callPackage ./qrtr/tqftpserv.nix { };
    pd-mapper = callPackage ./qrtr/pd-mapper.nix { };
    rmtfs = callPackage ./qrtr/rmtfs.nix { };

    #
    # Hacks
    # -----
    #
    # Totally not upstreamable stuff.
    #

    xf86-video-fbdev = super.xf86-video-fbdev.overrideAttrs({patches ? [], ...}: {
      patches = patches ++ [
        ./xserver/0001-HACK-fbdev-don-t-bail-on-mode-initialization-fail.patch
      ];
    });

    #
    # Fixes to upstream
    # -----------------
    #
    # All that follows will have to be cleaned and then upstreamed.
    #

    vboot-utils = super.vboot-utils.overrideAttrs(attrs: {
      # https://github.com/NixOS/nixpkgs/pull/69039
      postPatch = ''
        substituteInPlace Makefile \
          --replace "ar qc" '${self.stdenv.cc.bintools.targetPrefix}ar qc'
        substituteInPlace scripts/getversion.sh \
          --replace-fail "/usr/bin/env bash" "${self.bash}/bin/bash"
      '';
    });

    ubootTools = super.ubootTools.overrideAttrs({ buildInputs ? [], patches ? [], ... }: {
      # Needed for cross-compiling ubootTools
      buildInputs = buildInputs ++ [
        self.openssl
      ];
    });

    qt5 = super.qt5.overrideScope (_: qtSuper: {
      qtbase = qtSuper.qtbase.overrideAttrs (old: {
        setupHook = self.writeText "qtbase-setup-hook.sh" (
          builtins.replaceStrings
            [
              "        echo >&2 \"Error: detected mismatched Qt dependencies:\"\n        echo >&2 \"    @dev@\"\n        echo >&2 \"    $__nix_qtbase\"\n        exit 1\n"
            ]
            [
              "        echo >&2 \"Warning: mismatched Qt dependencies in cross build, continuing:\"\n        echo >&2 \"    @dev@\"\n        echo >&2 \"    $__nix_qtbase\"\n"
            ]
            (builtins.readFile old.setupHook)
        );
      });
    });

    sbc = super.sbc.overrideAttrs (old: {
      postPatch = (old.postPatch or "") + ''
        # GCC/C23 treats empty parameter lists as no-argument functions.
        # Upstream ARMv6 code calls naked asm helpers with args; cast explicitly.
        substituteInPlace sbc/sbc_primitives_armv6.c \
          --replace-fail 'sbc_analyze_eight_armv6(x, out, analysis_consts_fixed8_simd_odd);' \
            '((void (*)(int16_t *, int32_t *, const FIXED_T*))sbc_analyze_eight_armv6)(x, out, analysis_consts_fixed8_simd_odd);' \
          --replace-fail 'sbc_analyze_eight_armv6(x, out, analysis_consts_fixed8_simd_even);' \
            '((void (*)(int16_t *, int32_t *, const FIXED_T*))sbc_analyze_eight_armv6)(x, out, analysis_consts_fixed8_simd_even);'
      '';
    });

    gnutls = super.gnutls.overrideAttrs (old: {
      # Cross builds may try to run target doc helpers (errcodes/printlist),
      # which fails with "Exec format error". Disable docs when cross-compiling.
      configureFlags =
        (old.configureFlags or [])
        ++ self.lib.optionals (self.stdenv.buildPlatform != self.stdenv.hostPlatform) [
          "--disable-doc"
        ];
    });


    # Things specific to mobile-nixos.
    # Not necessarily internals, but they probably won't go into <nixpkgs>.
    mobile-nixos = {
      kernel-builder = callPackage ./mobile-nixos/kernel/builder.nix {};
      kernel-builder-gcc49 = callPackage ./mobile-nixos/kernel/builder.nix {
        stdenv = with self; overrideCC stdenv buildPackages.gcc49;
      };
      kernel-builder-gcc6 = callPackage ./mobile-nixos/kernel/builder.nix {
        stdenv = with self; overrideCC stdenv (
          if buildPackages ? gcc6
          then buildPackages.gcc6
          else buildPackages.gcc
        );
      };
      kernel-builder-gcc8 = callPackage ./mobile-nixos/kernel/builder.nix {
        stdenv = with self; overrideCC stdenv (
          if buildPackages ? gcc8
          then buildPackages.gcc8
          else buildPackages.gcc
        );
      };
      kernel-builder-clang_8 = callPackage ./mobile-nixos/kernel/builder.nix {
        stdenv = with self; overrideCC stdenv buildPackages.clang_8;
      };
      kernel-builder-clang_9 = callPackage ./mobile-nixos/kernel/builder.nix {
        stdenv = with self; overrideCC stdenv buildPackages.clang_9;
      };

      stage-1 = {
        script-loader = callPackage ../boot/script-loader {};
        boot-recovery-menu = callPackage ../boot/recovery-menu {};
        boot-error = callPackage ../boot/error {};
        boot-splash = callPackage ../boot/splash {};
      };

      # Flashable zip binaries are always static.
      android-flashable-zip-binaries = self.pkgsStatic.callPackage ./mobile-nixos/android-flashable-zip-binaries {};

      autoport = callPackage ./mobile-nixos/autoport {};

      boot-control = callPackage ./mobile-nixos/boot-control {};

      boot-recovery-menu-simulator = self.mobile-nixos.stage-1.boot-recovery-menu.simulator;
      boot-splash-simulator = self.mobile-nixos.stage-1.boot-splash.simulator;

      fdt-forward = callPackage ./mobile-nixos/fdt-forward {};

      gui-assets = callPackage ./mobile-nixos/gui-assets {};

      make-flashable-zip = callPackage ./mobile-nixos/android-flashable-zip/make-flashable-zip.nix {};

      map-dtbs = callPackage ./mobile-nixos/map-dtbs {};

      mkLVGUIApp = callPackage ./mobile-nixos/lvgui {};

      cross-canary-test = callPackage ./mobile-nixos/cross-canary/test.nix {};
      cross-canary-test-static = self.pkgsStatic.callPackage ./mobile-nixos/cross-canary/test.nix {};
    };

    imageBuilder = callPackage ../lib/image-builder {};
 }
