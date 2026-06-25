{
  description = "kenryo_tankyu dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      # Apple Silicon なら aarch64-darwin
      # Intel Mac なら x86_64-darwin に変える
      system = "aarch64-darwin";

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          android_sdk.accept_license = true;
        };
      };

      # Flutter の更新点はここだけに集約する。
      flutterVersion = "3.41.7";
      flutterHome = "/opt/homebrew/Caskroom/flutter/${flutterVersion}/flutter";
      flutter = pkgs.writeShellScriptBin "flutter" ''
        exec "${flutterHome}/bin/flutter" "$@"
      '';

    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          flutter
          pkgs.jdk17
          pkgs.ruby
          pkgs.cocoapods
        ];

        shellHook = ''
          export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
          export ANDROID_HOME=$ANDROID_SDK_ROOT
          export JAVA_HOME=${pkgs.jdk17}
          export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
          export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
        '';
      };
    };
}
