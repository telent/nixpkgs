{
  mkDerivation, lib,
  extra-cmake-modules, docbook_xml_dtd_45, docbook5_xsl,
  karchive, ki18n, qtbase,
  perl, perlPackages
}:

mkDerivation {
  name = "kdoctools";
  meta = { maintainers = [ lib.maintainers.ttuegel ]; };
  nativeBuildInputs = [ extra-cmake-modules ];
  propagatedBuildInputs = [ perl perlPackages.URI qtbase ];
  buildInputs = [ karchive ki18n ];
  outputs = [ "out" "dev" ];
  patches = [ ./kdoctools-no-find-docbook-xml.patch ];
  cmakeFlags = [
    "-DDocBookXML4_DTD_DIR=${docbook_xml_dtd_45}/xml/dtd/docbook"
    "-DDocBookXSL_DIR=${docbook5_xsl}/xml/xsl/docbook"
  ];
  postFixup = ''
    moveToOutput "share/doc" "$dev"
    moveToOutput "share/man" "$dev"
  '';
}
