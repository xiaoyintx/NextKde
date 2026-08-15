{
  # 使用 Home Manager 安装 vscode 以及 extensions
  home-manager.users.xiaoyintx =
    { pkgs, ... }:
    {
      programs.vscode = {
        enable = true;
      };
      extensions = with pkgs.vscode-extensions; [
        ms-python.python
        ms-vscode.cpptools
        rust-lang.rust-analyzer
      ];
    };
}