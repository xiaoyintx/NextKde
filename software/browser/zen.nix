{
  home-manager.users.winterl =
    { inputs, ... }:
    {
      imports = [
        inputs.zen-browser.homeModules.beta
      ];

      programs.zen-browser = {
        enable = true;
        setAsDefaultBrowser = true;

        languagePacks = [
          "zh-CN"
          "zh-TW"
        ];

        policies = {
          DisableTelemetry = true;
        };
      };
    };
}
