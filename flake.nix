{
  description = "kenryo_tankyu dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      forAllSystems = f:
        nixpkgs.lib.genAttrs supportedSystems (
          system:
            f system (import nixpkgs {
              inherit system;
              config = {
                allowUnfree = true;
                android_sdk.accept_license = true;
              };
            })
        );

    in {
      devShells = forAllSystems (system: pkgs: {
        default = pkgs.mkShell {
          packages = [
            pkgs.flutter
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
      });
    };
}
