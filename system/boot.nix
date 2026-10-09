{config, ...}: {
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-e421433e-454f-44ad-8fc3-352fe67c68b5".device = "/dev/disk/by-uuid/e421433e-454f-44ad-8fc3-352fe67c68b5";
}
