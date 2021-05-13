{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "rescript-language-server";
  version = "1.1.1";
  buildInputs = [ pkgs.unzip pkgs.nodejs ];
  src = pkgs.fetchurl {
    name = "rescript-vscode.zip";
    url = "https://github.com/rescript-lang/rescript-vscode/releases/download/1.1.1/rescript-vscode-1.1.1.vsix";
    sha256 = "sha256-lt0lEP+lod8VDdThF+VovcIlwIOdAGuTfwaH2b1EFgw=";
  };
  unpackPhase = ''
    mkdir -p $out/src
    ${pkgs.unzip}/bin/unzip $src -d $out/src
  '';
  installPhase = ''
    mkdir -p $out/bin
    echo "#!/bin/sh" >> $out/bin/rescript-language-server
    echo "${pkgs.nodejs}/bin/node $out/src/extension/server/out/server.js \"\$@\"" >> $out/bin/rescript-language-server
    chmod +x $out/bin/rescript-language-server
  '';
}
