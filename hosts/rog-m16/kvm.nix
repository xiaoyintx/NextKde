let
  # 设备的PCI ID
  # IOMMU Group 8:
  # 01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GA106M [GeForce RTX 3060 Mobile / Max-Q] [10de:2520] (rev a1)
  # 01:00.1 Audio device [0403]: NVIDIA Corporation GA106 High Definition Audio Controller [10de:228e] (rev a1)
  gpuIDs = [
    "10de:2520" # Graphics
    "10de:228e" # Audio
  ];
in
{ lib, pkgs, ... }:
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

  # KVM
  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
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
