# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:
let
    bsol = pkgs.fetchFromGitHub {
      owner = "harishnkr";
      repo = "bsol";
      rev = "v1.0";
      sha256 = "sha256-sUvlue+AXW6VkVYy3WOUuSt548b6LoDpJmQPbgcZDQw=";
    };
    customized_sddm_astronaut = pkgs.sddm-astronaut.override {
      embeddedTheme = "black_hole";
      themeConfig = {
        Background = "/etc/nixos/SDDM_Backgrounds/Ht0ML5.png";
      };
    };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./gpu_configuration.nix
      ./power_configuration.nix
      ./users/stefan.nix
      inputs.home-manager.nixosModules.default
    ];

  #Bootloader:
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    devices = [ "nodev" ];
    # Optional: Add this to automatically create entries for other OSs.
    useOSProber = true;
    theme = "${bsol}/bsol";
  };
  boot.loader.efi = {
    # Required for UEFI systems.
    canTouchEfiVariables = true;
    # Set the mount point of your EFI system partition.
    #efiSysMountPoint = "/boot/efi";
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs;[
      networkmanager-openvpn
    ];
  };

  #Initialize flakes:
  nix.settings.experimental-features = ["nix-command" "flakes"];

  #Set up garbage collecting:
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    extraPackages = with pkgs; [
      customized_sddm_astronaut
     ];
    theme = "sddm-astronaut-theme";
    settings = {
      Theme = {
        Current = "sddm-astronaut-theme";
      };
    };
  };
  services.desktopManager.plasma6.enable = true;
  programs.hyprland.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Bluetooth:
  hardware.bluetooth.enable = true;

  #Enable Noisetorch (virtual microphone; noise filtering):
  programs.noisetorch.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  security.sudo.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };



  #Virtualisation:
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = false; # needed for winboat
      setSocketVariable = true;
    };
  };


  #Setup Flatpak:
  services.flatpak.enable = true;

  #Setup FWUPD:
  services.fwupd.enable = true;

  #Enable appimages:
  programs.appimage = {
    enable = true;
    binfmt = true;
  };


  # List services that you want to enable:
  environment.systemPackages = with pkgs; [
    #Text edior:
    vim
    kdePackages.kate

    #FHS Shell
    (pkgs.buildFHSEnv {
      name = "fhs-dev";
      targetPkgs = pkgs: with pkgs; [
        (pkgs.python3.withPackages (ps: [
          ps.numpy
          ps.scipy
          ps.matplotlib
          ps.pandas
          ps.gmpy2
          ps.pytest
          ps.jupyterlab
          ps.jupyter-core
        ]))
        julia-lts
        jupyter-all
        gcc
        gfortran15
        zlib
        libgcc
        glibc
        mpich
        boost
        cgal
        gnumake
        gnum4
        flex
        bison
      ];
      profile = ''export FHS=1'';
      runScript = "fish";
    })

    #DE/Tiling:
    kdePackages.krohnkite
    kdePackages.aurorae
    kdePackages.kconfig

    #SDDM:
    customized_sddm_astronaut
    kdePackages.qtmultimedia

    #Compilers and other dependencies:
    gcc
    gnumake
    libgcc
    glibc
    gfortran15
    zlib
    gmp
    mpfr
    cacert

    #Terminal, Files, and extensions:
    lf
    mc
    btop-cuda
    alacritty
    kitty
    patchelf
    kdePackages.filelight
    kdePackages.discover
    gparted
    busybox

    #Math:
    maxima
    wxmaxima

    #Peripherals configuration:
    logitech-udev-rules
    libinput

    #ISO/Etchers:
    usbimager

    #Network:
    openvpn
    eduvpn-client

    #Virtualization/WinBoat:
    winboat
    freerdp
    docker-compose
    ];

  home-manager.backupFileExtension = "hm_backup";

  programs.fish.enable = true;

#   powerManagement.enable = true;
  boot.kernelParams = [
#     "mem_sleep_default=s2idle"
#     "nvidia_drm.fbdev=1"
#     "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  ];

  hardware.logitech.wireless.enable = true;
  services.ratbagd.enable = true;
  services.udev.packages = with pkgs; [ solaar ];
#   services.udev.extraRules = ''
#     ACTION=="add", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled"
#   '';

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [9999];
  networking.firewall.allowedUDPPorts = [4445 9999];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}

