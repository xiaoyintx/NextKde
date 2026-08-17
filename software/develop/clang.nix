{
  # 仅安装 clangd/clang-format 等工具（clang-tools），不安装 clang 编译器
  # 避免与 gcc 的 cc 冲突；clangd 用于 Zed 里 C++ 补全
  home-manager.users.xiaoyintx =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        clang-tools
      ];
    };
}
