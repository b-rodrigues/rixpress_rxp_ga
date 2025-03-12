let
 pkgs = import (fetchTarball "https://github.com/rstats-on-nix/nixpkgs/archive/2025-02-28.tar.gz") {};
 
  rpkgs = builtins.attrValues {
    inherit (pkgs.rPackages) 
      purrr
      data_table
      dplyr;
  };
  
  system_packages = builtins.attrValues {
    inherit (pkgs) 
      glibcLocales
      glibcLocalesUtf8
      nix
      pandoc
      quarto
      R;
  };

    rix = (pkgs.rPackages.buildRPackage {
      name = "rix";
      src = pkgs.fetchgit {
        url = "https://github.com/ropensci/rix/";
        rev = "6a7e8d0bf310006bd14445017ab753e8640ced71";
        sha256 = "sha256-9wXKJd+H05ArIORQwxoSPo7hOo+a5wJSoAnTNy7501A=";
      };
      propagatedBuildInputs = builtins.attrValues {
        inherit (pkgs.rPackages) 
          codetools
          curl
          jsonlite
          sys;
      };
    });

  rixpress = (pkgs.rPackages.buildRPackage {
    name = "rixpress";
    src = pkgs.fetchgit {
      url = "https://github.com/b-rodrigues/rixpress/";
      rev = "2a9c88b09620000580da87575cf6753e8a9dd072";
      sha256 = "sha256-rrrf9MhoOD49UlSIUshinzkwwZ9lBVhTSU3RQklGyew=";
    };
    propagatedBuildInputs = builtins.attrValues {
      inherit (pkgs.rPackages) 
        jsonlite
        igraph
        rlang;
    } ++ [rix];
  });
  

shell = pkgs.mkShell {
  LOCALE_ARCHIVE = if pkgs.system == "x86_64-linux" then "${pkgs.glibcLocales}/lib/locale/locale-archive" else "";
  LANG = "en_US.UTF-8";
   LC_ALL = "en_US.UTF-8";
   LC_TIME = "en_US.UTF-8";
   LC_MONETARY = "en_US.UTF-8";
   LC_PAPER = "en_US.UTF-8";
   LC_MEASUREMENT = "en_US.UTF-8";

  buildInputs = [ rpkgs rixpress system_packages ];
  
};
in
{
  inherit pkgs shell;
}