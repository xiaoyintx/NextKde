{
  # 使用 Home Manager 安装 clash gui
  home-manager.users.winterl =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        dotnet-sdk_11
        csharp-ls
      ];
    };
}
