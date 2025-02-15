{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "user";
  home.homeDirectory = "/home/user";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  
  programs.ssh = {
    enable = true;

    extraConfig = ''
      Host github.com
        IdentityFile ~/.ssh/id_ed25519_github
        User melonSorbet

      Host gitlab.com
        IdentityFile ~/.ssh/id_ed25519_gitlab
        User kilicyunusemre
    '';
  };
  home.packages = with pkgs;[
    
    mesa
    wayland
    egl-wayland
    kitty
    alacritty
    discord

    kitty
    neovim	
    wl-clipboard

    jetbrains-mono
    jetbrains.rust-rover
    vscode
    rustc
    cargo
    gcc
    git
  ];
 programs.alacritty = {
    enable = true;
    settings = {
      env = {
        WINIT_UNIX_BACKEND = "wayland"; # Force Wayland backend
      };
    };
  };

  programs.git = {
    enable = true;
    userName =  "melonSorbet";
    userEmail = "kilicyunusemre678@gmail.com";
  };


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
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
  #  /etc/profiles/per-user/user/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  # Create the .development directory
  

  xdg.dataFile = {
    "applications/Alacritty.desktop".text = ''
      [Desktop Entry]
      Version=1.0
      Name=Alacritty
      Comment=Alacritty terminal emulator
      Exec=nixGL alacritty %F
      Icon=Alacritty
      Terminal=false
      Type=Application
      Categories=Utility;TerminalEmulator;
      StartupNotify=true
    '';
  };

   home.file.".config/nvim".source  = builtins.fetchGit{
   	url = "https://github.com/melonSorbet/nvim.git";
	ref = "master";
   };
   home.file.".config/alacritty".source  = builtins.fetchGit{
   	url = "https://github.com/melonSorbet/alacritty.git";
	ref = "main";
   };
  programs.home-manager.enable = true;
}
