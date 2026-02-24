# Agent Rules

## Explicit Package Dependencies

- Do not use optional package-attribute checks like `pkgs ? foo`.
- Do not use conditional inclusion based on package-attribute existence.
- If a package is required, declare and use it explicitly.
- If a package is not guaranteed in the current package set, fail clearly and early instead of silently skipping it.

