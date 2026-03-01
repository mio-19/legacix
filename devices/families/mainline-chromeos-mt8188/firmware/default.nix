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
    mediatek/mt8188/scp.img \
    mediatek/mt8188/mt8188-mcu.bin \
    qca/rampatch_00440302.bin \
    qca/nvm_00440302.bin \
  ; do
    install_one "$firmware"
  done
''
