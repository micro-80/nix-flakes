{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    clang-tools

    typescript
    typescript-language-server
  ];
}
