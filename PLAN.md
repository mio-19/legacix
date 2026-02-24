# legacix Plan

## Goal

Build a practical legacy-device stack that combines:

- AsteroidOS-derived kernel and device bring-up work
- AsteroidOS custom UI components for watch-focused UX
- Nixpkgs-native base system reuse (for example `systemd`) to maximize cache hits

## High-Level Direction

1. Keep reusing AsteroidOS device/kernel knowledge where it is strong (vendor kernel patches, device-specific integration details).
2. Prefer Nixpkgs packages for common system components whenever possible.
3. Use Nixpkgs binary cache aggressively to reduce local build time and CI cost.

## Phase 1: Kernel and Device Baseline

- Continue initial `hoki` bring-up using AsteroidOS `meta-hoki` kernel patch stack.
- Stabilize boot, framebuffer, and basic device init path.
- Document which AsteroidOS pieces are currently imported and pinned.

## Phase 2: AsteroidOS UI Enablement

- Package and integrate AsteroidOS custom UI components needed for smartwatch UX.
- Start with launcher/compositor path and required UI runtime dependencies.
- Define a minimal boot-to-UI target profile for watch devices.
- Keep UI packaging modular so device targets can opt in progressively.

## Phase 3: Nixpkgs Base Reuse

- Use `nixpkgs` as the default source for general-purpose packages:
  - `systemd`
  - core userspace tools and libraries
  - non-device-specific middleware
- Only carry device-specific overrides when upstream `nixpkgs` cannot satisfy requirements.
- Track and minimize divergence from upstream package definitions.

## Phase 4: Binary Cache Strategy

- Prioritize builds that can reuse existing `nixpkgs` cache artifacts.
- Avoid unnecessary local rebuilds of unchanged `nixpkgs` packages.
- Keep custom derivations focused on device-specific deltas (kernel patches, hybris/binder integrations, watch UI packaging).
- Document expected cache hit/miss behavior per build profile.

## Phase 5: Integration and Hardening

- Build end-to-end images for `hoki` with:
  - AsteroidOS-derived kernel support
  - AsteroidOS custom UI stack
  - Nixpkgs-based base system components
- Validate boot reliability, UI startup, and key watch interactions.
- Add regression checks for kernel build, image assembly, and UI package closure.

## Non-Goals (for now)

- Full feature parity with upstream AsteroidOS in the first milestone.
- Replacing `nixpkgs` core packages with custom forks unless strictly required.

## Immediate Next Steps

1. Finish `hoki` kernel bring-up validation.
2. Select first AsteroidOS UI components to package in Nix (launcher/compositor path).
3. Define exact package boundary: what stays from AsteroidOS vs what comes directly from Nixpkgs.
4. Add build docs explaining expected binary cache usage and fallback behavior.
