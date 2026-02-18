{ config, pkgs, flatpaks, ... }:
{
    programs.home-manager.enable = true;
    home.stateVersion = "25.11";

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
    qtox

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

  programs.git = {
    enable = true;
    settings.user = {
      email = "stefan.amarfii52@gmail.com";
      name = "Hz2i";
    };
  };

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
  };

  home.sessionVariables = {
    EDITOR= "kate";
    TERMINAL = "alactritty";
    BROWSER = "firefox";
  };
}
