{ config, pkgs, lib, inputs, ... }:

{
  home-manager.users.winterl = { config, pkgs, lib, inputs, ... }: {
    imports = [
      inputs.zen-browser.homeModules.beta
    ];

    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;

      languagePacks = [ "zh-CN" "zh-TW" ];

      policies = {
        DisableTelemetry = true;
      };
    };
  };
}
