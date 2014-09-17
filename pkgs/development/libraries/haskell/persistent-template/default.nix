# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, aeson, hspec, monadControl, monadLogger, pathPieces
, persistent, QuickCheck, tagged, text, transformers
, unorderedContainers
}:

cabal.mkDerivation (self: {
  pname = "persistent-template";
  version = "2.0.2.2";
  sha256 = "1qar8xh4nbprnvqzgy4byc882hkfyxr7apbj0wzfs7smpla1ghlx";
  buildDepends = [
    aeson monadControl monadLogger pathPieces persistent tagged text
    transformers unorderedContainers
  ];
  testDepends = [
    aeson hspec persistent QuickCheck text transformers
  ];
  jailbreak = true;
  meta = {
    homepage = "http://www.yesodweb.com/book/persistent";
    description = "Type-safe, non-relational, multi-backend persistence";
    license = self.stdenv.lib.licenses.mit;
    platforms = self.ghc.meta.platforms;
  };
})
