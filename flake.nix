{
  description = "Marketplace - Dev Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            # Backend
            python311
            poetry
            python311Packages.black      # Formateador
            python311Packages.isort

            # Frontend
            nodejs_20
            nodePackages.pnpm            # Mejor que npm/yarn para Nix

            # Docker
            docker
            docker-compose
            dive                         # Inspeccionar imágenes Docker

            # DB Tools
            postgresql_16                # Para acceder a PSQL local
            sqlite                       # Para desarrollo rápido

            # Utilidades
            syncthing                     # Sincronización de secretos
            git
            gh                           # GitHub CLI
            jq                           # Manipular JSON
            curl
          ];

          shellHook = ''
            echo "Marketplace Dev Shell"
            echo "Backend: Python $(python --version)"
            echo "Frontend: Node $(node --version)"
            echo ""
            echo "Comandos útiles:"
            echo "  docker compose up -d  # Levantar servicios"
            echo "  poetry install        # Instalar dependencias Python"
            echo "  pnpm install          # Instalar dependencias Node"
            echo "  pnpm dev              # Levantar frontend en dev"
            echo "  syncthing &           # Sincroniza secretos automáticamente"
          '';
        };
      });
}
