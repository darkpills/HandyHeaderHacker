{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs}:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      python = pkgs.python313;
      deps = with pkgs; [
      ];
      pkg = python.pkgs.buildPythonPackage {
        pname = "HandyHeaderHacker";
        version = "0.1.0";
        src = pkgs.fetchFromGitHub {
          owner = "darkpills";
          repo = "HandyHeaderHacker";
          rev = "d3f86e26d2840ba01b6ce5140ef8028e7f145d8b";
          sha256 = "sha256-Tx//GgEXJFHXD0dlOHnRvPMIsu1Wf+F0ipGYP/noKlM=";
        };
        propagatedBuildInputs = deps;
        doCheck = false;
        pyproject = false;
        build-system = [ python.pkgs.setuptools ];
        nativeBuildInputs = deps;
        postInstall = ''
          mkdir -p $out/bin
          cp -r $src/* $out/bin/
          ln -s $out/bin/hhh.py $out/bin/hhh
          ln -s $out/bin/hhh.py $out/bin/HandyHeaderHacker
          chmod +x $out/bin/hhh
          chmod +x $out/bin/HandyHeaderHacker
      '';
      };
    in
    {
      packages.${system}.default = pkg;

    };
}
