{inputs, config, pkgs, ... }:
{
  nixpkgs.overlays = [(final: super: {
    waybar = super.waybar.overrideAttrs({ patches ? [], ... } : {
      patches = patches ++ [
        # Patch for timer support
        (final.fetchpatch {
          url = "https://github.com/gopi487krishna/Waybar/commit/75e5f523b42a1fb4a145e2b27ced4a6fb0c52d9d.patch";
          hash = "sha256-vKwW1/04SjYJIOh/EXWuS+d29RaxESSfNWVyVxFxGOU=";
        })

        (final.fetchpatch {
          url = "https://github.com/gopi487krishna/Waybar/commit/953642a7548ab39721e914f25f486d7ca71a9f52.patch";
          hash = "sha256-NsM9k6NbWxkxvbIAETexws1jzL0GPUXzZQcltbLwXMM=";
        })

      ];
    });
  })];
}
