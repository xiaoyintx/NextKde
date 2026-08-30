{
    pkgs,
    lib,
    ...
}:

{
    # 启用 zsh 并设置为系统默认 shell
    programs.zsh.enable = true;

    # 将用户的默认登录 shell 设为 zsh
    users.users.xiaoyintx.shell = pkgs.zsh;

    # 使用 Home Manager 配置 zsh 与 oh-my-zsh
    home-manager.users.xiaoyintx =
        { pkgs, lib, ... }:
        {
            programs.zsh = {
                enable = true;
                autosuggestion.enable = true;
                syntaxHighlighting.enable = true;
                shellAliases = {
                    ll = "ls -lah";
                    vim = "nvim";
                    update = "sudo nixos-rebuild switch --flake .#omen-16";
                };
                initContent = lib.mkBefore ''
                    # 自定义 zsh 配置
                    export EDITOR=nvim
                    # 右侧提示符：显示时间与 git 状态
                    setopt PROMPT_SUBST
                    autoload -Uz vcs_info
                    precmd() {
                      vcs_info
                    }
                    zstyle ':vcs_info:git:*' formats '%F{green}(%b%u%c)%f'
                    zstyle ':vcs_info:*:*' check-for-changes true
                    zstyle ':vcs_info:*:*' unstagedstr '%F{red}*%f'
                    zstyle ':vcs_info:*:*' stagedstr '%F{yellow}+%f'
                    RPROMPT='[%D{%H:%M:%S}] ''${vcs_info_msg_0_}'
                '';
                oh-my-zsh = {
                    enable = true;
                    plugins = [
                        "git"
                        "sudo"
                        "z"
                        "hitokoto"
                        "history"
                    ];
                    theme = "agnoster";
                };
            };
        };
}
