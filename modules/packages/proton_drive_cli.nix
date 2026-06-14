{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  libsecret,
}:

stdenv.mkDerivation rec {
  pname = "proton-drive";
  version = "0.4.4";

  src = fetchurl {
    url = "https://proton.me/download/drive/cli/0.4.4/linux-x64/proton-drive";
    sha512 = "7ae6700ddd4479c976a787bba46dd610b0037c5b17bd71f06519ced9af6ddf75e7b9d9b7f87ad2daf8be981b7ac072960c5855b23429a1442fc8f389707ede6e";
  };

  dontUnpack = true;
  dontStrip = true;

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    libsecret
  ];

  installPhase = ''
    mkdir -p $out/bin

    # 2. Copia o próprio arquivo baixado ($src) direto para a pasta destino
    cp $src $out/bin/${pname}

    chmod +x $out/bin/${pname}
  '';

  meta = with lib; {
    description = "CLI para o proton drive";
    homepage = "https://proton.me/pt-br/drive";
    platforms = platforms.linux;
  };
}
