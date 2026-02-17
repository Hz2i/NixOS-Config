{ config, pkgs, flatpaks, ... }:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
    programs.home-manager.enable = true;
    home.stateVersion = "25.11";
  # Please read the comment before changing.
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # The home.packages option allows you to install Nix packages into your
  # environment.
    home.username = "stefan";
    home.homeDirectory = "/home/stefan";

    home.packages = with pkgs;[
    #Git:
    git
    gitui
    delta

    #Communication services:
    thunderbird
    discord
    whatsapp-electron

    #Media (Entertainment):
    spotify
    firefox

    #Utility:
    p7zip-rar
    libreoffice
    pinta
    vscode
    qbittorrent
    masterpdfeditor4
    orca-slicer
    kicad
    remmina
    mokutil
    cabextract
    samba
    spacenavd
    gettext
    virtualgl
    wine

    #Terminal:
    starship
    zellij

    #Peripherals/Hardware:
    solaar
    fastfetch

    #Simulation:
    xflr5

    #Games:
    steam
    mangohud
    protonup-qt
    vkd3d-proton
    vkd3d
    dxvk
    protontricks
    prismlauncher
    osu-lazer-bin
    ];

  programs.fish = {
    enable = true;
    functions = {
    fish_greeting = "";
      };
    };

#   programs.git = {
#     enable = true;
#     settings.user = {
#       email = "stefan.amarfii52@gmail.com";
#       name = "Hz2i";
#     };
    programs.git = {
    enable = true;
    settings.user = {
      email = "amarfii@student.tudelft.nl";
      name = "samarfii";
    };
  };
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
#     ".config/krohnkiterc".text = ''
#       [General]
#       noBorders - false
#       borderWidth=5
#       screenGap=10
#       layoutGap=10
#       frame=61,174,233
#       inactiveFrame=239,240,241
#       tileLayout=tile
#       useSplash=false
#       ignoreClass=plasmashell,plasma-desktop,krunner
#       ignoreTitle=@Invalid()
#       keepAbove=@Invalid()
#       keepBelow=@Invalid()
#     '';
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/stefan/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR= "kate";
    TERMINAL = "alactritty";
    BROWSER = "firefox";
  };
}
