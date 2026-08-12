{
    # 使用 home-manager  安装 Google Chrome
    home-manager.users.xiaoyintx = 
    { pkgs,... }:
    {
      home.packages = with pkgs; [
        google-chrome
      ];
    };
}