{inputs, config, pkgs, ... }:
{
 nixpkgs.overlays = [(final: super: {
   kanagawa-gtk-theme = super.kanagawa-gtk-theme.overrideAttrs({ patches ? [], ... } : {
     patches = patches ++ [
       # Patch for timer support
       (final.fetchpatch {
         url = "https://github.com/gopi487krishna/Kanagawa-GKT-Theme/commit/b1d3f25325200fd8267167eaacf1d6df596ca44d.patch";
         hash = "sha256-IJ1xVhpSPHsKq+nyQGusHs0eoG3ntI1NCHV6qB1utDA=";
       })
     ];
   });
 })];
}
