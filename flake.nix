{
  description = "LinuxPenguins's website";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.flockenzeit.url = "github:balsoft/flockenzeit";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    flockenzeit,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};

      version = builtins.substring 0 8 self.lastModifiedDate;

      BUILD_DATE = with flockenzeit.lib.splitSecondsSinceEpoch {} self.lastModified; "${F}T${T}${Z}";
      VCS_REF = "${self.rev or "dirty"}";
    in {
      checks.html = pkgs.stdenv.mkDerivation {
        name = "linuxpenguins-html-${version}";
        src = ./html;
        buildInputs = [pkgs.html-proofer];
        buildPhase = ''
          htmlproofer . --disable-external
        '';
        installPhase = ''
          mkdir -p $out
          cp -r . $out
        '';
      };

      packages.default = pkgs.stdenv.mkDerivation {
        name = "linuxpenguins-${version}";
        src = ./html;
        buildPhase = ''
          sed -i 's,SHA,'"${VCS_REF}"',' ./index.html
          sed -i 's,REF,'"${BUILD_DATE}"',' ./index.html
        '';
        installPhase = ''
          mkdir -p $out
          cp -r . $out
        '';
      };

      devShells.default =
        pkgs.mkShell {buildInputs = [pkgs.html-proofer];};
    });
}
