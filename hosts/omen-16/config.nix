{
    pkgs,
    config,
    lib,
    ...
}:

{
    imports = [
        # Boot Loader
        ../../boot/grub.nix
        # User
        ../../user/xiaoyintx.nix
        # GPU（i7-14650HX + RTX 4060 Laptop 混合显卡：Intel iGPU + NVIDIA）
        ../../gpu/intel.nix
        ../../gpu/nvidia.nix
        # Fonts
        ../../fonts/maple-mono-nf-cn.nix
        ../../fonts/sarasa-gothic.nix
        ../../fonts/monaspace.nix
        # Desktop Environment
        ../../desktop/plasma/config.nix
        # Input Method
        ../../input-method/fcitx5.nix
        # Shell
        ../../shell/zsh.nix
        # Network Agent
        ../../software/network/clash/clash.nix
        ../../software/network/clash/clash-proxy.nix
        # Desktop Software
        ../../software/browser/chrome.nix
        ../../software/normal/qq.nix
        ../../software/normal/wechat.nix
        ../../software/normal/feishu.nix
        ../../software/normal/steam.nix
        ../../software/normal/lutris.nix
        ../../software/normal/obs-studio.nix
        ../../software/normal/opencode.nix
        ../../software/normal/moonlight.nix
        # Develop
        ../../software/develop/clang.nix # clangd：C/C++ 补全
        ../../software/develop/clion.nix
        ../../software/develop/gcc.nix
        ../../software/develop/zig.nix
        ../../software/develop/rust.nix
        ../../software/develop/vscode/vscode.nix
        ../../software/develop/vscode/vscode-settings.nix
        ../../software/develop/zed/zed-editor.nix
        ../../software/develop/zed/zed-coding.nix # Zed 开发环境：任务/调试/脚手架
    ];

    # ============================================================
    # CPU：Intel Core i7-14650HX（Raptor Lake Refresh）
    # ============================================================
    # Intel CPU 微码（安全补丁，必须启用）
    hardware.cpu.intel.updateMicrocode = true;

    # 默认内核：NixOS 官方 unstable（多内核启动项见下方 specialisation）
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Intel 平台电源管理
    powerManagement.cpuFreqGovernor = "powersave";

    # ============================================================
    # 混合显卡（Optimus）：Intel iGPU 渲染 + NVIDIA 按需调用
    # ============================================================
    # RTX 4060 Laptop 为 Turing 及之后架构，open 内核模块可用
    hardware.nvidia.prime = {
        # Intel iGPU 输出（笔记本内屏走 Intel，保证休眠/省电正常）
        intelBusId = "PCI:0:2:0";
        # RTX 4060 Laptop 的 PCI ID
        nvidiaBusId = "PCI:1:0:0";

        # 默认 Intel 渲染，NVIDIA 按需调用（nvidia-offload 命令）
        offload = {
            enable = true;
            enableOffloadCmd = true; # 提供 nvidia-offload 命令
        };
    };
    hardware.bluetooth = {
        enable = true;
        settings.General.Experimental = true;
    };

    # ============================================================
    # 系统
    # ============================================================
    system.stateVersion = "26.11";

    i18n.defaultLocale = "zh_CN.UTF-8";

    home-manager.users.xiaoyintx =
        { ... }:
        {
            home.stateVersion = "26.11";
        };
}
