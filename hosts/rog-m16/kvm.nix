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

  # 给 libvirt 提供不会包含 Nix store 哈希的固定固件路径。
  systemd.tmpfiles.rules = [
    "L+ /run/ovmf-ms - - - - ${ovmfMs}"
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
