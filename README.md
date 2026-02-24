# legacix (name subject to change)

> **Large warning:** This project, including this README, contains significant LLM-generated content.  
> Review code, docs, and configuration carefully before relying on them.

`legacix` is a fork (name subject to change) based on Mobile NixOS. It is a superset on top of [NixOS Linux](https://nixos.org/nixos/), [Nixpkgs](https://nixos.org/nixpkgs/), and [Nix](https://nixos.org/nix/), aiming to abstract away the differences between mobile devices.

In four words: "NixOS, on your phone".

## Fork Context

This repository is a fork focused on legacy Android vendor-based devices.

It is based on upstream Mobile NixOS state at commit [`d22c60e8d4d21f0197c1cac88c34dcc366b7a16c`](https://github.com/mobile-nixos/mobile-nixos/tree/d22c60e8d4d21f0197c1cac88c34dcc366b7a16c), the last commit before vendor-device removal in PR [#645](https://github.com/mobile-nixos/mobile-nixos/pull/645).

Upstream documented this direction change in issue [#643](https://github.com/mobile-nixos/mobile-nixos/issues/643) ("Vendor-based devices are not a supported use-case anymore"), citing maintenance burden, security concerns from old vendor kernels, and poor long-term viability.

This fork intentionally keeps support for downstream vendor kernels, `libhybris`, and Halium-style integration layers. A key motivation is to reuse and share porting work with adjacent projects still targeting Android-based legacy hardware, including:

- [Droidian](https://droidian.org/)
- [AsteroidOS](https://asteroidos.org/)
- [AsteroidOS FAQ (`libhybris` context)](https://wiki.asteroidos.org/index.php/Frequently_Asked_Questions_(FAQ))

## Nix Support Policy

Only Nix Flakes are supported in this repository.
Legacy non-flake workflows are not supported.

This flake includes AsteroidOS `meta-smartwatch` as a non-flake input for
kernel patch reuse and related integration work:

- https://github.com/AsteroidOS/meta-smartwatch
- https://github.com/AsteroidOS/asteroid-launcher
- https://github.com/AsteroidOS/qml-asteroid
- https://github.com/AsteroidOS/lipstick
- https://github.com/mer-hybris/bluebinder
- https://github.com/mer-hybris/qt5-qpa-hwcomposer-plugin
- https://github.com/fossil-engineering/kernel-msm-fossil-cw

Common commands:

- `nix develop`
- `nix flake show`

## AsteroidOS Reuse Status

First target added: `hoki` (Fossil Gen 6 platform).

Current reuse in-tree:

- `meta-hoki` kernel defconfig + patch stack from `meta-smartwatch`
- `kernel-msm-fossil-cw` source pinned to AsteroidOS `linux-hoki` revision

Additional AsteroidOS pieces identified (not yet ported here):

- `meta-hoki` `android-system-data`
- `android-init` additions and property contexts
- initramfs script overlays
- hybris/binder userspace pieces (`bluebinder`, etc.)
- device bbappends for `bluez`, `geoclue`, `pulseaudio`
- Nemo/mobile pieces (`lipstick`, `nfcd`, `ngfd`, `libnci`)
- out-of-tree audio modules (`linux-audio-modules-hoki`)

## Project Plan

This project follows the roadmap in [PLAN.md](PLAN.md).
New work should be implemented against the current phase goals in that plan.

## Documentation

- [Mobile NixOS website](https://mobile.nixos.org/) (rendered documentation)
- [NixOS Manual](https://nixos.org/nixos/manual)
- [Nixpkgs Manual](https://nixos.org/nixpkgs/manual/)
- [Nix Manual](https://nixos.org/nix/manual)

## Community

Mobile NixOS development and questions are mostly hosted on:

- [NixOS on ARM (Matrix)](https://matrix.to/#/#nixos-on-arm:nixos.org?via=nixos.org&via=matrix.org)

General NixOS resources:

- [Nix and NixOS support (Matrix)](https://matrix.to/#/#nix:nixos.org?via=nixos.org&via=matrix.org)

## Contributing

Contributions are welcome:

- [Contributing guide](CONTRIBUTING.adoc)
- [Contributing to Nixpkgs/NixOS](https://github.com/NixOS/nixpkgs/blob/master/.github/CONTRIBUTING.md)

## License

This repository is licensed under the [MIT License](LICENSE).

As with Nixpkgs, the MIT license applies to repository files (expressions, scripts, modules, etc.), not automatically to all built packages, which retain their own licenses.
