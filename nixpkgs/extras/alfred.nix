{ stdenv, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "Alfred";
  version = "4.1.1_1172";

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    echo "Installing Alfred to: $out/Applications/Alfred.app"
    mkdir -p "$out/Applications"
    cp -r "Alfred 4.app" "$out/Applications/Alfred.app"
  '';

  src = fetchurl {
    name = "Alfred-${version}.dmg";
    url = "https://cachefly.alfredapp.com/Alfred_${version}.dmg";
    sha256 = "0m31xxkqv0j57kmhwxwhq5ml2dg635sv7bg5mcjj4d2s9p77g3bs";
  };

  meta = with stdenv.lib; {
    description = "Alfred productivity tool";
    homepage = "https://www.alfredapp.com";
    maintainers = [ ];
    platforms = platforms.darwin;
  };
}
