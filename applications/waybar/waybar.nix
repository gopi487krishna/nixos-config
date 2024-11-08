{inputs, config, pkgs, ... }:
{
  nixpkgs.overlays = [(final: super: {
    waybar = super.waybar.overrideAttrs({ patches ? [], ... } : {
      # Patch for timer support
      patches = patches ++ [
        (final.fetchpatch {
          url = "https://github.com/gopi487krishna/Waybar/commit/9f0d6d69fbf5941573b9f443f3c4e6d297b969a3.patch";
          hash = "sha256-ONCRpndcNR18vcrZs0mEhmW7kFWFDRGqQBpUfbNObVA=";
        })

        (final.fetchpatch {
          url = "https://github.com/gopi487krishna/Waybar/commit/953642a7548ab39721e914f25f486d7ca71a9f52.patch";
          hash = "sha256-NsM9k6NbWxkxvbIAETexws1jzL0GPUXzZQcltbLwXMM=";
        })

      ];
    });
  })];
}
