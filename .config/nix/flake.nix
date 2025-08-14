{
  description = "Zen nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    system = "aarch64-darwin";
    pkgs = import nixpkgs { inherit system; };    

    configuration = { pkgs, config, ... }: {
      system.primaryUser = "vegardsjavik";

      nixpkgs.config.allowUnfree = true;
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [

        # Terminal utils
        pkgs.eza
        pkgs.fd
        pkgs.fzf
        pkgs.ripgrep
        pkgs.xh
        pkgs.xz
        pkgs.zoxide
        pkgs.stow

        # Development
        pkgs.neovim
        pkgs.neovide
        pkgs.tmux
        pkgs.git

        # TUI
        pkgs.lazydocker
        pkgs.lazygit
        pkgs.bat
        pkgs.btop
        pkgs.yazi

        pkgs.nodejs_24
        pkgs.cargo

        # MacOS specifics
        pkgs.mkalias 

      ];

      homebrew = {
        enable = true;
        taps = [
          "nikitabobko/tap"
        ];
        brews = [

        ];
        casks = [
          "aerospace"
          "ghostty"
          "raycast"
          "spotify"
          "visual-studio-code"
        ];
        onActivation.cleanup = "zap";
      };
      fonts.packages = [
        pkgs.nerd-fonts.fira-mono
      ];

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      
      system.defaults = {
        dock.autohide = true;
        screensaver.askForPasswordDelay = 10;
      };

      in
        pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
        '';

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      programs.fish.enable = true;
      users.users.vegardsjavik = {
        name = "vegardsjavik";
        home = "/Users/vegardsjavik";
        shell = pkgs.fish;
      };

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."air" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration 
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
              enable = true;
              enableRosetta = true;

              user = "vegardsjavik";

              autoMigrate = true;
            };
        }
      ];
    };
  };
}
