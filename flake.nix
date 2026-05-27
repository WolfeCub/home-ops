{
  description = "Homelab environment tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};

        helm-with-secrets = pkgs.wrapHelm pkgs.kubernetes-helm {
          plugins = [
            pkgs.kubernetes-helmPlugins.helm-secrets
          ];
        };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            kubectl
            kubectx

            helm-with-secrets
            fluxcd
            sops

            talosctl
            talhelper
          ];

          shellHook = ''
            echo "⛵ Homelab environment loaded!"
            echo "----------------------------------------"

            # Use kubectx/kubens to grab the current state cleanly
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
      }
    );
}
