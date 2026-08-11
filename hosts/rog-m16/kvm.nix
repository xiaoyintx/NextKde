{ lib, pkgs, ... }:
let
  # 设备的PCI ID
  # IOMMU Group 8:
  # 01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GA106M [GeForce RTX 3060 Mobile / Max-Q] [10de:2520] (rev a1)
  # 01:00.1 Audio device [0403]: NVIDIA Corporation GA106 High Definition Audio Controller [10de:228e] (rev a1)
  gpuIDs = [
    "10de:2520" # Graphics
    "10de:228e" # Audio
  ];

  # 带 Secure Boot 支持和 Microsoft 预置密钥的 OVMF 固件。
  # 新版 nixpkgs 不再提供 virtualisation.efi 或 libvirtd.qemu.ovmf 选项，
  # 因此将固件暴露在稳定路径下，由虚拟机 XML 直接引用。
  ovmfMs = (pkgs.OVMF.override {
    secureBoot = true;
    msVarsTemplate = true;
  }).fd;

  ssdt = pkgs.fetchurl {
    url = "https://lantian.pub/usr/uploads/202007/ssdt1.dat";
    sha256 = "07403kfy2s6v1x844l69pn7v88cqx1yjrqbnnpwfvz9h3kf3x5qx";
  };
in
{
  specialisation."GPUPaththrough".configuration = {
    system.nixos.tags = [
      "Nvidia-GPU-vfio"
      "NoXpad"
    ];

    # 把vfio的内核模块放在nvidia的内核模块之前的是有意的，因为它让vfio在nvidia之前声明要使用这个 GPU
    boot.initrd.kernelModules = [
      # vifo
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
    ];
    boot.kernelParams = [
      ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs) # vfio-pci
    ];
  };

  # 安全启动密钥，假电池
  systemd.tmpfiles.rules = [
    "L+ /run/ovmf-ms - - - - ${ovmfMs}"
    "d /opt/UserItems 0755 root root -"
    "L+ /opt/UserItems/ssdt.dat - - - - ${ssdt}"
  ];

  # KVM
  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
  };

  # libvirt 的默认 NAT 网络通过 virbr0 向虚拟机提供 DHCP、DNS 和转发。
  # 将网桥设为可信接口，避免 NixOS 防火墙阻断虚拟机获取地址。
  # dae 会改变路由路径，使用 loose rpfilter 避免合法的转发流量被反向路径检查丢弃。
  networking.firewall = {
    trustedInterfaces = [ "virbr0" ];
    checkReversePath = "loose";
  };

  users.users.winterl.extraGroups = [ "libvirtd" ];
  environment.systemPackages = with pkgs; [
    virt-manager
    dnsmasq
  ];

  # NVIDIA Prime
  hardware.nvidia.prime = {
    intelBusId = "PCI:0@0:2:0";
    nvidiaBusId = "PCI:1@0:0:0";
  };

}
