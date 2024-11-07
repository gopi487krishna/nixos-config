{inputs, config, pkgs, ... }:
{
  nixpkgs.overlays = [(final: super: {
    waybar = super.waybar.overrideAttrs({ patches ? [], ... } : {
      # Patch for timer support
      patches = patches ++ [
        (final.fetchpatch {
          url = "https://github.com/gopi487krishna/Waybar/commit/3596e10388f03fc2230f805265a1c3dc03f64492.patch";
          hash = "";
        })
      ];
    });
  })];
}
