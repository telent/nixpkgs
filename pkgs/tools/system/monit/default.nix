{stdenv, fetchurl, openssl, bison, flex, pam, zlib
, buildPlatform, hostPlatform
, usePAM ? stdenv.isLinux }:

let useSSL = (openssl != null);
    cross = ( buildPlatform != hostPlatform ) ; in
stdenv.mkDerivation rec {
  name = "monit-5.23.0";

  src = fetchurl {
    url = "${meta.homepage}dist/${name}.tar.gz";
    sha256 = "04v7sp2vc1q6h8c5j8h4izffn9d97cdj0k64m4ml00lw6wxgwffx";
  };

  nativeBuildInputs = [ bison flex ];
  buildInputs = [ zlib.dev ] ++
  stdenv.lib.optionals useSSL [ openssl ] ++
  stdenv.lib.optionals usePAM [ pam ];

  configureFlags = ( if useSSL then [
    "--with-ssl-incl-dir=${openssl.dev}/include"
    "--with-ssl-lib-dir=${openssl.out}/lib"
  ] else [ "--without-ssl" ] ) ++
    stdenv.lib.optionals (! usePAM) [ "--without-pam" ] ++
    stdenv.lib.optionals cross [ "libmonit_cv_setjmp_available=yes"
                     "libmonit_cv_vsnprintf_c99_conformant=yes"  ]    ;

  meta = {
    homepage = http://mmonit.com/monit/;
    description = "Monitoring system";
    license = stdenv.lib.licenses.agpl3;
    maintainers = with stdenv.lib.maintainers; [ raskin wmertens ];
    platforms = with stdenv.lib.platforms; linux;
  };
}
