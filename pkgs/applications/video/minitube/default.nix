{ stdenv, fetchFromGitHub, wrapQtAppsHook, phonon, phonon-backend-vlc, qtbase, qmake
, qtdeclarative, qttools, qtx11extras, mpv

# "Free" key generated by nckx <github@tobias.gr>. I no longer have a Google
# account. You'll need to generate (and please share :-) a new one if it breaks.
, withAPIKey ? "AIzaSyBtFgbln3bu1swQC-naMxMtKh384D3xJZE" }:

stdenv.mkDerivation rec {
  pname = "minitube";
  version = "3.2";

  src = fetchFromGitHub {
    sha256 = "0175sgqmszakqd631bni4aqjpx68h6n49zjvg23fb1yyancnkn4c";
    rev = version;
    repo = "minitube";
    owner = "flaviotordini";
    fetchSubmodules = true;
  };

  buildInputs = [ phonon phonon-backend-vlc qtbase qtdeclarative qttools qtx11extras mpv ];
  nativeBuildInputs = [ wrapQtAppsHook qmake ];

  qmakeFlags = [ "DEFINES+=APP_GOOGLE_API_KEY=${withAPIKey}" ];

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "Stand-alone YouTube video player";
    longDescription = ''
      Watch YouTube videos in a new way: you type a keyword, Minitube gives
      you an endless video stream. Minitube is not about cloning the YouTube
      website, it aims to create a new TV-like experience.
    '';
    homepage = "https://flavio.tordini.org/minitube";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ ];
  };
}
