{inputs, config, pkgs, ... }:
{
  nixpkgs.overlays = [(final: super: {
    rofi-wayland-unwrapped = super.rofi-wayland-unwrapped.overrideAttrs({ patches ? [], ... }: {
      patches = patches ++ [
        (final.fetchpatch {
          url = "https://github.com/samueldr/rofi/commit/55425f72ff913eb72f5ba5f5d422b905d87577d0.patch";
          hash = "sha256-vTUxtJs4SuyPk0PgnGlDIe/GVm/w1qZirEhKdBp4bHI=";
        })
      ];
    });
  })];
}
