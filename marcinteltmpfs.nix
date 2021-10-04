{ config, pkgs, ... }:

{
  hardware.cpu.intel.updateMicrocode = true;

  hardware.opengl.extraPackages = with pkgs; [
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
    intel-media-driver
  ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.timeout = 1;

  networking.networkmanager.enable = true;

  networking.enableIPv6 = false;

  services.xserver.xkbVariant = "intl";
  services.xserver.wacom.enable = true;

  services.acpid.enable = true;

  services.haveged.enable = true;

  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "ondemand"; # "ondemand", "powersave", "performance", "schedutil"?

  #services.mbpfan.enable = true; # only on mac

  hardware.bluetooth.enable = true;
  # hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;

  users.users.user.initialPassword = "rootofallevil";
  #users.users.root.initialPassword = "rootofallevil";

  #users.mutableUsers = false;

  nix.gc.automatic = true;
  nix.optimise.automatic = true;

  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "00:05" ;
  system.autoUpgrade.allowReboot = true;

  services.fstrim.enable = true;
  boot.kernel.sysctl = { "vm.swappiness" = 1; };

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "defaults" "size=2G" "mode=755" ];
  };
  
  # Don't allow mutation of users outside of the config.
  # users.mutableUsers = false;

  # Set a root password, consider using initialHashedPassword instead.
  #
  # To generate a hash to put in initialHashedPassword
  # you can do this:
  # $ nix-shell --run 'mkpasswd -m SHA-512 -s' -p mkpasswd
  users.users.root.initialPassword = "rootofallevil";

  # machine-id is used by systemd for the journal, if you don't
  # persist this file you won't be able to easily use journalctl to
  # look at journals for previous boots.
  environment.etc."machine-id".source
    = "/nix/persist/etc/machine-id";

  # if you want to run an openssh daemon, you may want to store the
  # host keys across reboots.
  #
  # For this to work you will need to create the directory yourself:
  # $ mkdir /nix/persist/etc/ssh
  #environment.etc."ssh/ssh_host_rsa_key".source
  #  = "/nix/persist/etc/ssh/ssh_host_rsa_key";
  #environment.etc."ssh/ssh_host_rsa_key.pub".source
  #  = "/nix/persist/etc/ssh/ssh_host_rsa_key.pub";
  #environment.etc."ssh/ssh_host_ed25519_key".source
  #  = "/nix/persist/etc/ssh/ssh_host_ed25519_key";
  #environment.etc."ssh/ssh_host_ed25519_key.pub".source
  #  = "/nix/persist/etc/ssh/ssh_host_ed25519_key.pub";

  # Use systemd boot (EFI only)
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;

  # Use the GRUB 2 boot loader (Both EFI and legacy boot supported).
  #boot.loader.grub.enable = true;

  # This is for GRUB in EFI mode
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";

}
