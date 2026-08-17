{
  # 微信 Linux 版：本地化下载 & 新版本 hash 检测
  # ============================================================
  # 下载走腾讯国内 CDN 直连（dldir1v6.qq.com），替换 nixpkgs 默认使用的
  # web.archive.org（归档站，国内慢且经常失败）。
  #
  # 该 URL 是「滚动最新版」直链，文件名不带版本号。腾讯一更新，文件内容就变，
  # → hash 变化 → 触发 hash mismatch。这就是检测新版本的机制：
  #   - 主动检测 / 更新 hash：运行  scripts/wechat-update.sh
  #   - 被动：nix build 报 hash mismatch，把新 hash 填回 package/wechat/default.nix
  # ============================================================

  home-manager.users.xiaoyintx =
    { pkgs, config, ... }:
    {
      home.packages = [ pkgs.localpkg.wechat ];
    };
}
