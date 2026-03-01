{
  lib,
  runCommand,
  linux-firmware,
}:

# Minimal firmware set for MT8188 ChromeOS family.
runCommand "mt8188-chromeos-firmware" {
  src = linux-firmware;
  meta.license = linux-firmware.meta.license;
} ''
  install_one() {
    rel="$1"
    if [ -e "$src/lib/firmware/$rel" ]; then
      mkdir -p "$(dirname "$out/lib/firmware/$rel")"
      cp -vrf "$src/lib/firmware/$rel" "$out/lib/firmware/$rel"
    fi
  }

  for firmware in \
    mediatek/mt8188/scp_c0.img \
    mediatek/mt8188/scp.img \
    mediatek/mt8188/mt8188-mcu.bin \
    qca/rampatch_00440302.bin \
    qca/nvm_00440302.bin \
  ; do
    install_one "$firmware"
  done

  # Newer kernels expect scp_c0.img; linux-firmware may not ship mt8188 SCP
  # blobs yet, so keep symlink targets non-broken for image generation.
  if [ ! -e "$out/lib/firmware/mediatek/mt8188/scp_c0.img" ]; then
    mkdir -p "$out/lib/firmware/mediatek/mt8188"
    if [ -e "$out/lib/firmware/mediatek/mt8188/scp.img" ]; then
      cp -f "$out/lib/firmware/mediatek/mt8188/scp.img" "$out/lib/firmware/mediatek/mt8188/scp_c0.img"
    else
      dd if=/dev/zero of="$out/lib/firmware/mediatek/mt8188/scp_c0.img" bs=1 count=1
      cp -f "$out/lib/firmware/mediatek/mt8188/scp_c0.img" "$out/lib/firmware/mediatek/mt8188/scp.img"
    fi
  fi
''
