{
    pkgs,
    lib,
    ...
}:

{
    # ============================================================
    # KVM 虚拟化配置（libvirt + QEMU + virt-manager）
    # ============================================================

    # 启动 libvirt 守护进程
    virtualisation.libvirtd = {
        enable = true;
        qemu = {
            package = pkgs.qemu_kvm;
            swtpm.enable = true;
        };
    };

    # SPICE USB 设备重定向
    virtualisation.spiceUSBRedirection.enable = true;

    # KVM 内核对模块
    boot.kernelModules = [
        "kvm-intel"
        "vfio"
        "vfio_iommu_type1"
    ];

    # 内核参数（IOMMU 透传）
    boot.kernelParams = [
        "intel_iommu=on"
        "iommu=pt"
    ];
    networking.firewall = {
        trustedInterfaces = [ "virbr0" ];
        checkReversePath = "loose";
    };

    # dconf 支持（virt-manager 通过 dconf 记忆连接）
    programs.dconf.enable = true;

    # 用户加入虚拟化组（libvirtd + kvm）
    users.users.xiaoyintx.extraGroups = [
        "libvirtd"
        "kvm"
    ];

    # 图形化与管理工具
    environment.systemPackages = with pkgs; [
        virt-manager
        virt-viewer
        qemu_kvm
        libguestfs
        fastfetch
    ];

    # 让桌面会话以中文运行，virt-manager 等 GTK 应用显示中文界面
    environment.sessionVariables = {
        LANG = "zh_CN.UTF-8";
        LC_ALL = "zh_CN.UTF-8";
    };

    home-manager.users.xiaoyintx =
        { pkgs, ... }:
        {
            home.packages = with pkgs; [
                libvirt
            ];

            # 声明式指定 virt-manager 默认连接，避免启动时弹出
            # "无法检测到默认虚拟机管理程序" 提示
            dconf.settings = {
                "org/virt-manager/virt-manager/connections" = {
                    autoconnect = [ "qemu:///system" ];
                    uris = [ "qemu:///system" ];
                };
            };
        };
}
