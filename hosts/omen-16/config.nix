{ pkgs, config, lib, ... }:

{
  imports = [
    # Boot Loader（GRUB，支持多内核启动项选择）
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
    # Desktop Software
    ../../software/zed-editor.nix
    ../../software/browser/chrome.nix
    ../../software/qq.nix
    ../../software/wechat.nix
    ../../software/feishu.nix
    ../../software/steam.nix
    ../../software/lutris.nix
    ../../software/obs-studio.nix
    ../../software/moonlight.nix
    # Develop
    ../../software/develop/clang.nix
    ../../software/develop/zig.nix
    ../../software/develop/rust.nix
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

  # NVIDIA 高功耗场景用专属性能模式（与 nvidia.powerManagement 协同）
  services.tlp = {
    enable = true;
    settings = {
      # 电池优先省电，接电优先性能
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      # 禁止 NVIDIA 独占显存时仍激活独显（交给 runtime PM 管理）
      RUNTIME_PM_DRIVER_BLACKLIST = "";
    };
  };

  # ============================================================
  # 多内核启动项（GRUB 菜单可选）
  # 默认内核：NixOS 官方 unstable（上述 boot.kernelPackages）
  # specialisation 会为每个内核生成独立的 "NixOS (<name>)" 启动项
  # ============================================================
  specialisation = {
    # LTS 内核：NixOS 长期支持版，稳定优先
    "linux-lts".configuration = {
      boot.kernelPackages = pkgs.linuxPackages_lts;
    };

    # CachyOS 内核：针对游戏/桌面性能优化
    "linux-cachyos".configuration = {
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
    };
  };

  # 限制 GRUB 保留的旧内核项数量，避免长期 rebuild 后 ESP 累积
  boot.loader.grub = {
    configurationLimit = 10;
    timeout = 5; # 秒
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