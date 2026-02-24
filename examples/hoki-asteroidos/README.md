# hoki AsteroidOS-style images

This profile builds a `hoki` image set in AsteroidOS-style layout:

- `asteroidos.ext4`
- `boot.img`

Non-flake command:

```bash
nix-build examples/hoki-asteroidos -A outputs.default
```
