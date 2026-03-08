{
  description = "Flutter Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            android_sdk.accept_license = true;
            allowUnfree = true;
          };
        };

        # Compose the Android SDK with the versions you need
        androidComposition = pkgs.androidenv.composeAndroidPackages {
          platformVersions = [ "33" "28" ];
          abiVersions = [ "x86_64" ];
          includeEmulator = true;
          includeSystemImages = true;
        };

        # The specific attribute in nixpkgs unstable is usually 'androidsdk'
        androidSdk = androidComposition.androidsdk;
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.flutter
            pkgs.jdk17
            androidSdk
            pkgs.google-chrome # Useful for flutter web debugging
          ];

          # Environment variables to help Flutter find everything on NixOS
          shellHook = ''
            export ANDROID_HOME="${androidSdk}/libexec/android-sdk"
            export ANDROID_SDK_ROOT="${androidSdk}/libexec/android-sdk"
            export JAVA_HOME="${pkgs.jdk17.home}"
            export CHROME_EXECUTABLE="${pkgs.google-chrome}/bin/google-chrome"
            
            echo "--- Flutter Dev Environment Loaded ---"
            echo "Android SDK: $ANDROID_HOME"
            echo "Java Home:   $JAVA_HOME"
          '';
        };
      }
    );
}
