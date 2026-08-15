# Clash Verge Rev 代理环境变量
#
# 前提：本机已通过 software/clash.nix 说明的方式安装并运行 Clash Verge Rev
# Clash Verge Rev 默认混合端口为 7897（HTTP + SOCKS5 二合一）。
# 若你在 Clash 设置里修改过端口，请同步修改下面 7897 的所有地方。
{
  lib,
  ...
}:
let
  proxyAddr = "http://127.0.0.1:7897";
  # 不走代理的本地地址
  noProxy = "localhost,127.0.0.1,::1";
in
{
  # 用户级环境变量（仅对用户 xiaoyintx 的会话生效）
  home-manager.users.xiaoyintx.home.sessionVariables = {
    http_proxy = proxyAddr;
    https_proxy = proxyAddr;
    all_proxy = proxyAddr;
    HTTP_PROXY = proxyAddr;
    HTTPS_PROXY = proxyAddr;
    ALL_PROXY = proxyAddr;
    NO_PROXY = noProxy;
  };

  # 让 nix-daemon 也走代理，使 `nixos-rebuild` / `nix` 拉取依赖时借助代理
  # nix-daemon 以 root 运行，无法使用上面的用户级变量，故在此单独设置（系统级）
  # 注意：代理未启动时 nix 走代理的下载会失败；若不想全局走代理可删除本段
  systemd.services.nix-daemon.environment = {
    http_proxy = proxyAddr;
    https_proxy = proxyAddr;
    all_proxy = proxyAddr;
    HTTP_PROXY = proxyAddr;
    HTTPS_PROXY = proxyAddr;
    ALL_PROXY = proxyAddr;
    NO_PROXY = noProxy;
  };
}
