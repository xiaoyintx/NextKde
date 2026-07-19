{ config, pkgs, lib, hostName, ... }:

{
  # NVIDIA 驱动配置
  services.xserver.videoDrivers = [ "nvidia" ];
  
  # NVIDIA 硬件配置
  hardware = {
    # 启用 NVIDIA 驱动
    nvidia = {
      # modesetting
      modesetting.enable = true;
      
      # NVIDIA 持久化守护进程
      powerManagement.enable = true;
      
      # NVIDIA 设置工具
      nvidiaSettings = false;
      
      # DRM (Direct Rendering Manager)
      open = false;  # 使用闭源驱动，更稳定
      
      # 动态电源管理
      powerManagement.finegrained = false;
      
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
