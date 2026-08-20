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
            ovmf.enable = true;
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
        virt-install
        fastfetch
    ];

    home-manager.users.xiaoyintx =
        { pkgs, ... }:
        {
            home.packages = with pkgs; [
                libvirt
            ];
        };
}