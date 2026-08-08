{
  pkgs,
  ...
}:
let
  zen-browser-flake = import (builtins.fetchTarball {
    url = "https://v6.gh-proxy.org/https://github.com/youwen5/zen-browser-flake/archive/master.tar.gz";
    sha256 = "1xy6szz0l294av7iz97klbb9v259018mbsg46429zyx86zymcr61"; 
  }) { inherit pkgs; };
in
{
  home-manager.users.winterl.home.packages = [ zen-browser-flake.zen-browser ];
}