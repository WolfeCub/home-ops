{
  description = "Homelab environment tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    flake-parts.url = "github:hercules-ci/flake-parts";

    flate-bin = {
      url = "https://github.com/home-operations/flate/releases/download/v0.4.9/flate_0.4.9_linux_amd64.tar.gz";
      flake = false;
    };
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux"];

      perSystem = {pkgs, ...}: let
        helm-with-secrets = pkgs.wrapHelm pkgs.kubernetes-helm {
          plugins = [pkgs.kubernetes-helmPlugins.helm-secrets];
        };

        flate = pkgs.stdenv.mkDerivation {
          name = "flate";
          src = inputs.flate-bin;

          nativeBuildInputs = [pkgs.autoPatchelfHook];
          installPhase = ''
            # The tarball extracts the binary directly, so we just install it
            install -m755 -D flate $out/bin/flate
          '';
        };
      in {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            kubectl
            kubectx
            kubecolor
            helm-with-secrets
            fluxcd
            sops
            talosctl
            talhelper
            yaml-language-server
            flate
            k9s
          ];

          shellHook = ''
            echo "⛵ Homelab environment loaded!"
            echo "----------------------------------------"
            CTX=$(kubectx -c 2>/dev/null || echo "Not set")
            if [ "$CTX" != "Not set" ]; then
              NS=$(kubens -c 2>/dev/null || echo "default")
            else
              NS="Not set"
            fi
            echo "Cluster Context: $CTX"
            echo "Namespace:       $NS"
            echo "----------------------------------------"
          '';
        };
      };
    };
}
