{ pkgs, isMacos }:

let
  url =
    if isMacos then
      "https://github.com/alexherbo2/kakoune.cr/releases/download/nightly/kakoune.cr-nightly-x86_64-apple-darwin.zip"
    else
      "https://github.com/alexherbo2/kakoune.cr/releases/download/nightly/kakoune.cr-nightly-x86_64-unknown-linux-musl.zip";
  sha256 =
    if isMacos then
      "sha256-LOFcPzaOGJP2CJ/tMQ+aNx8N66zH286jU+XWiANqSjQ="
    else
      "";
in
pkgs.stdenv.mkDerivation rec {
  pname = "kaoune.cr";
  version = "nightly";
  buildInputs = [ pkgs.unzip ];
  src = pkgs.fetchurl {
    name = "kakoune-cr.zip";
    url = url;
    sha256 = sha256;
  };
  phases = [ "unpackPhase" ];
  unpackPhase = ''
    ${pkgs.unzip}/bin/unzip $src -d $out
  '';
}
