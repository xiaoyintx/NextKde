{
    # 基于 Zed 的 Rust + C++ 开发环境配置
    # Rust 使用 rust-analyzer + CodeLLDB，C++ 单文件用 g++ 编译（无 clangd）
    home-manager.users.xiaoyintx =
        { pkgs, config, ... }:
        {
            home.packages = with pkgs; [
                lldb # CodeLLDB 依赖的底层调试库（Zed 会自动下载 codelldb 适配器）
                clang-tools # clang-format：C++ 保存时自动格式化
                # 项目脚手架脚本
                (pkgs.writeShellScriptBin "new-rust" ''
                      set -euo pipefail
                      name="''${1:?用法: new-rust <项目名>}"
                      cargo new --bin "$name"
                      ( cd "$name"
                        mkdir -p .zed
                        cat > .zed/debug.json <<EOF
                    [
                      {
                        "label": "Debug $name",
                        "adapter": "CodeLLDB",
                        "request": "launch",
                        "program": "\$ZED_WORKTREE_ROOT/target/debug/$name",
                        "args": [],
                        "cwd": "\$ZED_WORKTREE_ROOT",
                        "build": { "command": "cargo", "args": ["build"], "cwd": "\$ZED_WORKTREE_ROOT" },
                        "sourceLanguages": ["rust"],
                        "stopOnEntry": false
                      }
                    ]
                    EOF
                        echo "== 已生成 $name，开始编码: zed $name"
                      )
                '')
                (pkgs.writeShellScriptBin "new-cpp" ''
                      set -euo pipefail
                      name="''${1:-main}"
                      mkdir -p "$name"
                      f="$name/$name.cpp"
                      [ -e "$f" ] || cat > "$f" <<'EOF'
                    #include <iostream>
                    int main() {
                        std::cout << "Hello, C++!" << std::endl;
                        return 0;
                    }
                    EOF
                      echo "== 已生成 $f，用 Zed 打开后按 Ctrl+Shift+T 选择运行任务"
                '')
            ];

            # ---------- Zed 全局配置 ----------
            xdg.configFile."zed/settings.json" = {
                force = true;
                text = ''
                    {
                      // 主题：从 VS Code 配色迁移的自定义主题
                      "theme": "xiaoyintx-dark",
                      // 编辑器字体
                      "buffer_font_family": "Maple Mono NF CN",
                      "buffer_font_size": 16,
                      // UI 字体与系统一致（更纱黑体，fontconfig 中 sans-serif → Sarasa UI SC）
                      "ui_font_family": "Sarasa UI SC",
                      "ui_font_size": 14,
                      // 项目面板放到左侧
                      "project_panel": { "dock": "left" },
                      // 显式启用 Zed 官方 vim mode（经典默认风格）
                      "vim_mode": true,
                      "vim": {
                        "default_mode": "normal",
                        "use_system_clipboard": "always",
                        "use_smartcase_find": true,
                        "toggle_relative_line_numbers": true
                      },
                      // 语言服务器：Rust 用 rust-analyzer；C/C++ 用 clangd 提供补全
                      "lsp": {
                        "rust-analyzer": {
                          "binary": { "path": "rust-analyzer" },
                          "initialization_options": {
                            "check": { "command": "clippy" },
                            "cargo": { "buildScripts": { "enable": true } }
                          }
                        },
                        "clangd": {
                          "binary": { "path": "clangd" },
                          "arguments": ["--background-index", "--clang-tidy"]
                        }
                      },
                      // 调试器使用 CodeLLDB（首次调试时 Zed 会自动下载该适配器）
                      "dap": {
                        "CodeLLDB": {}
                      },
                      "format_on_save": "on",
                      "inlay_hints": {
                        "enabled": true,
                        "show_hints": true
                      },
                      "languages": {
                        "Rust": {
                          "language_servers": ["rust-analyzer", "!copilot"]
                        },
                        "C": {
                          "language_servers": ["clangd", "!copilot"],
                          "tab_size": 4,
                          "formatter": {
                            "external": {
                              "command": "clang-format",
                              "arguments": [
                                "--style=file:${config.home.homeDirectory}/.clang-format",
                                "--assume-filename={buffer_path}"
                              ]
                            }
                          },
                          "format_on_save": "on"
                        },
                        "C++": {
                          "language_servers": ["clangd", "!copilot"],
                          "tab_size": 4,
                          "formatter": {
                            "external": {
                              "command": "clang-format",
                              "ARGUMENTS": [
                                "--style=file:${config.home.homeDirectory}/.clang-format",
                                "--assume-filename={buffer_path}"
                              ]
                            }
                          },
                          "format_on_save": "on"
                        },
                        "Nix": {
                          "language_servers": ["nil", "!copilot"],
                          "tab_size": 4,
                          "formatter": {
                            "external": {
                              "command": "nixfmt",
                              "arguments": ["--indent", "4"]
                            }
                          },
                          "format_on_save": "on"
                        }
                      }
                    }
                '';
            };

            # C++ 格式化规则（由 VS Code 的 C_Cpp.vcFormat 迁移而来：所有大括号同行）
            home.file.".clang-format" = {
                force = true;
                text = ''
                    ---
                    BasedOnStyle: LLVM
                    # 对应 vcFormat newLine.beforeOpenBrace.* = sameLine（函数/块/lambda/命名空间/类型）
                    BreakBeforeBraces: Attach
                    # 空格/缩进：4 空格
                    IndentWidth: 4
                    ColumnLimit: 0
                    SortIncludes: false
                    TabWidth: 4
                    UseTab: Never
                    AllowShortFunctionsOnASingleLine: Empty
                    AllowShortIfStatementsOnASingleLine: Never
                    PointerAlignment: Left
                    ---
                '';
            };

            # 全局运行任务（快捷键 Ctrl+Shift+T 呼出）
            xdg.configFile."zed/tasks.json" = {
                force = true;
                text = ''
                    [
                      {
                        "label": "Rust: cargo run",
                        "command": "cargo",
                        "args": ["run"],
                        "cwd": "$ZED_WORKTREE_ROOT",
                        "use_new_terminal": true,
                        "tags": ["rust"]
                      },
                      {
                        "label": "Rust: cargo build",
                        "command": "cargo",
                        "args": ["build"],
                        "cwd": "$ZED_WORKTREE_ROOT",
                        "use_new_terminal": true,
                        "tags": ["rust"]
                      },
                      {
                        "label": "Rust: cargo test",
                        "command": "cargo",
                        "args": ["test"],
                        "cwd": "$ZED_WORKTREE_ROOT",
                        "use_new_terminal": true,
                        "tags": ["rust"]
                      },
                      {
                        "label": "C++: 编译并运行当前文件",
                        "command": "bash",
                        "args": [
                          "-c",
                          "g++ -std=c++23 -g -O0 -Wall \"$ZED_FILE\" -o /tmp/zed_cpp_run && /tmp/zed_cpp_run"
                        ],
                        "cwd": "$ZED_WORKTREE_ROOT",
                        "use_new_terminal": true,
                        "tags": ["cpp"]
                      }
                    ]
                '';
            };

            # 全局调试配置（C++ 单文件固定路径；Rust 由 new-rust 生成的 .zed/debug.json 提供）
            xdg.configFile."zed/debug.json" = {
                force = true;
                text = ''
                    [
                      {
                        "label": "C++: 调试当前文件",
                        "adapter": "CodeLLDB",
                        "request": "launch",
                        "program": "/tmp/zed_cpp_dbg",
                        "cwd": "$ZED_WORKTREE_ROOT",
                        "build": {
                          "command": "bash",
                          "args": ["-c", "g++ -std=c++23 -g -O0 -Wall \"$ZED_FILE\" -o /tmp/zed_cpp_dbg"],
                          "cwd": "$ZED_WORKTREE_ROOT"
                        },
                        "stopOnEntry": false
                      }
                    ]
                '';
            };

            # 主题：由 VS Code workbench.colorCustomizations 迁移而来（深色，Zed v0.2 schema）
            xdg.configFile."zed/themes/xiaoyintx-dark.json" = {
                force = true;
                text = ''
                    {
                      "$schema": "https://zed.dev/schema/themes/v0.2.0.json",
                      "author": "xiaoyintx",
                      "name": "xiaoyintx",
                      "themes": [
                        {
                          "name": "xiaoyintx-dark",
                          "appearance": "dark",
                          "style": {
                            "background": "#0e1415",
                            "border": "#3f4949",
                            "border.variant": "#252b2b",
                            "border.focused": "#80d4d7",
                            "border.selected": "#80d4d7",
                            "conflict": "#ffb4ab",
                            "created": "#80d4d7",
                            "deleted": "#ffb4ab",
                            "modified": "#b4c7e9",
                            "hidden": "#899393",
                            "ignored": "#899393",
                            "renamed": "#b4c7e9",
                            "unreachable": "#899393",
                            "error": "#ffb4ab",
                            "warning": "#b4c7e9",
                            "info": "#80d4d7",
                            "hint": "#b0cccc",
                            "success": "#80d4d7",
                            "predictive": "#80d4d7",
                            "elevated_surface.background": "#252b2b",
                            "surface.background": "#161d1d",
                            "panel.background": "#161d1d",
                            "panel.focused_border": "#80d4d7",
                            "status_bar.background": "#1a2121",
                            "title_bar.background": "#161d1d",
                            "title_bar.inactive_background": "#0e1415",
                            "toolbar.background": "#161d1d",
                            "tab_bar.background": "#0e1415",
                            "tab.active_background": "#0e1415",
                            "tab.inactive_background": "#161d1d",
                            "text": "#ffffff",
                            "text.accent": "#80d4d7",
                            "text.muted": "#ccd6d6",
                            "text.placeholder": "#a8b3b3",
                            "text.disabled": "#899393",
                            "element.background": "#1a2121",
                            "element.hover": "#80d4d733",
                            "element.active": "#80d4d7",
                            "element.selected": "#80d4d7",
                            "element.disabled": "#252b2b",
                            "ghost_element.background": "#161d1d",
                            "ghost_element.hover": "#dde4e310",
                            "ghost_element.selected": "#80d4d733",
                            "icon": "#80d4d7",
                            "icon.muted": "#899393",
                            "icon.disabled": "#899393",
                            "icon.accent": "#80d4d7",
                            "icon.placeholder": "#899393",
                            "editor.background": "#0e1415",
                            "editor.foreground": "#dde4e3",
                            "editor.gutter.background": "#0e1415",
                            "editor.line_number": "#899393",
                            "editor.active_line_number": "#80d4d7",
                            "editor.active_line.background": "#1a2121",
                            "editor.highlighted_line.background": "#1a2121",
                            "editor.subheader.background": "#1a2121",
                            "terminal.background": "#0e1415",
                            "terminal.foreground": "#dde4e3",
                            "terminal.ansi.black": "#252b2b",
                            "terminal.ansi.red": "#ffb4ab",
                            "terminal.ansi.green": "#80d4d7",
                            "terminal.ansi.yellow": "#354863",
                            "terminal.ansi.blue": "#80d4d7",
                            "terminal.ansi.magenta": "#b4c7e9",
                            "terminal.ansi.cyan": "#b0cccc",
                            "terminal.ansi.white": "#dde4e3",
                            "terminal.ansi.bright_black": "#899393",
                            "terminal.ansi.bright_red": "#ffb4ab",
                            "terminal.ansi.bright_green": "#80d4d7",
                            "terminal.ansi.bright_yellow": "#b4c7e9",
                            "terminal.ansi.bright_blue": "#80d4d7",
                            "terminal.ansi.bright_magenta": "#b4c7e9",
                            "terminal.ansi.bright_cyan": "#b0cccc",
                            "terminal.ansi.bright_white": "#dde4e3",
                            "syntax": {
                              "comment": { "color": "#b0cccc99", "font_style": "italic" },
                              "comment.doc": { "color": "#b0cccc99", "font_style": "italic" },
                              "comment.block.documentation": { "color": "#b0cccc99", "font_style": "italic" },
                              "punctuation": { "color": "#dde4e3" },
                              "punctuation.bracket": { "color": "#bec8c8" },
                              "punctuation.special": { "color": "#ffb4ab" },
                              "variable": { "color": "#80d4d7" },
                              "keyword": { "color": "#80d4d7" },
                              "keyword.directive": { "color": "#ffb4ab" },
                              "constant": { "color": "#b4c7e9" },
                              "string": { "color": "#b0cccc" },
                              "string.special": { "color": "#ffb4ab" },
                              "number": { "color": "#80d4d7" },
                              "boolean": { "color": "#80d4d7" },
                              "type": { "color": "#b4c7e9" },
                              "type.parameter": { "color": "#dde4e3" },
                              "function": { "color": "#80d4d7" },
                              "method": { "color": "#80d4d7" },
                              "builtin": { "color": "#80d4d7" },
                              "module": { "color": "#b4c7e9" },
                              "operator": { "color": "#dde4e3" },
                              "property": { "color": "#b0cccc" },
                              "tag": { "color": "#b4c7e9" },
                              "tag.attribute": { "color": "#80d4d7" },
                              "label": { "color": "#80d4d7" },
                              "emphasis": { "font_style": "italic" },
                              "strong": { "font_style": "bold" },
                              "link_text": { "color": "#80d4d7", "font_style": "underline" },
                              "link_uri": { "color": "#b0cccc", "font_style": "underline" }
                            }
                          }
                        }
                      ]
                    }
                '';
            };

            # 快捷键：快捷运行 / 重跑
            xdg.configFile."zed/keymap.json" = {
                force = true;
                text = ''
                    [
                      {
                        "context": "Workspace",
                        "bindings": {
                          "ctrl-t": ["task::Spawn"]
                        }
                      },
                      {
                        "context": "Editor && vim_mode == insert && !menu",
                        "bindings": {
                          "esc": ["vim::SwitchMode", "normal", "workspace::Save", "editor::Format"]
                        }
                      }
                    ]
                '';
            };
        };
}
