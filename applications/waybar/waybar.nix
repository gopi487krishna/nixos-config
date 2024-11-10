{inputs, config, pkgs, ... }:
{
  nixpkgs.overlays = [(final: super: {
    waybar = super.waybar.overrideAttrs({ patches ? [], ... } : {
      patches = patches ++ [
        # Patch for timer support
        (final.fetchpatch {
          url = "https://github.com/gopi487krishna/Waybar/commit/d2aa353e382172d04e444dfe0777339714c9f4ae.patch";
          hash = "sha256-IC5LhbGbHF0ncbwablI52eJ6+wsvWoXQ9GC4M+bI39E=";
        })

        (final.fetchpatch {
          url = "https://github.com/gopi487krishna/Waybar/commit/953642a7548ab39721e914f25f486d7ca71a9f52.patch";
          hash = "sha256-NsM9k6NbWxkxvbIAETexws1jzL0GPUXzZQcltbLwXMM=";
        })

      ];
    });
  })];
}
