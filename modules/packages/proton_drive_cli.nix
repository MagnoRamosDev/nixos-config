{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  libsecret,
  glib,
  makeWrapper,
}:

stdenv.mkDerivation rec {
  pname = "proton-drive";
  version = "0.4.4";

  src = fetchurl {
    url = "https://proton.me/download/drive/cli/0.6.0/linux-x64/proton-drive";
    sha512 = "e77f5b27a51a81063c23c15ac0a9f07e0ec5c868e78670f34b45b3c3c2e679ed769e6225796b900d0d02735a0c52a21eba72356f3ad617de076c405532e698dc";
  };

  dontUnpack = true;
  dontStrip = true;

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    libsecret
    glib
    stdenv.cc.cc.lib
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${pname}
    chmod +x $out/bin/${pname}

    wrapProgram $out/bin/${pname} \
      --prefix LD_LIBRARY_PATH : "${
        lib.makeLibraryPath [
          libsecret
          glib
          stdenv.cc.cc.lib
        ]
      }" \
      --prefix PATH : "${lib.makeBinPath [ libsecret ]}"
  '';

  meta = with lib; {
    description = "CLI para o proton drive";
    homepage = "https://proton.me/pt-br/drive";
    platforms = platforms.linux;
  };
}
