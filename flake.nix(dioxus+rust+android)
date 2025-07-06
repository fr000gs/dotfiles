{
  description = "Android NDK FHS Shell";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.default = let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
      };
    in
      pkgs.buildFHSEnv {
        name = "ndk-clang-env";
        targetPkgs = pkgs: with pkgs; [
          gcc
          glibc
          #glib
          zlib
          #atkmm
          #cairo
          coreutils
          openssl.dev
          #pkg-config
          wasm-bindgen-cli
          dioxus-cli
          jdk
          openssl
          gnumake
          nodejs
        ];
        runScript = "bash";
        profile = ''
          export ANDROID_NDK=$ANDROID_NDK_HOME
          export ANDROID_HOME=/home/fr000gs/Android/Sdk/
          export OPENSSL_LIB_DIR=${pkgs.openssl.out}/lib
          export OPENSSL_INCLUDE_DIR=${pkgs.openssl.dev}/include
          export PKG_CONFIG_PATH=${pkgs.openssl.dev}/lib/pkgconfig
          export LD_LIBRARY_PATH=${pkgs.openssl.out}/lib:$LD_LIBRARY_PATH
          export SLINT_BACKEND=winit-skia
          export PATH="$HOME/Android/Sdk/platform-tools:$PATH"
        '';
        #nativeBuildInputs = [ pkgs.pkg-config ];
        #buildInputs = [ pkgs.openssl.dev ];
        #LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ pkgs.openssl ];
      };
  };
}
