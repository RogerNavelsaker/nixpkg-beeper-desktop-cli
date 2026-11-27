{ autoPatchelfHook, fetchurl, lib, stdenv, stdenvNoCC }:

let
  manifest = builtins.fromJSON (builtins.readFile ./package-manifest.json);
  binary = manifest.binary.name;
in
stdenvNoCC.mkDerivation {
  pname = "beeper-desktop-cli";
  version = manifest.source.version;

  src = fetchurl {
    url = manifest.source.url;
    hash = manifest.source.hash;
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ stdenv.cc.cc.lib ];
  sourceRoot = ".";
  dontConfigure = true;
  dontBuild = true;
  dontStrip = true; # bun-compiled executable carries its payload after the ELF sections

  installPhase = ''
    runHook preInstall
    install -Dm755 bin/${binary} "$out/bin/${binary}"
    runHook postInstall
  '';

  meta = with lib; {
    description = manifest.meta.description;
    homepage = manifest.meta.homepage;
    license = licenses.mit;
    mainProgram = binary;
    platforms = [ "x86_64-linux" ];
  };
}
