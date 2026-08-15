{
  # vscode userSettings（从 gitee settings.json 迁移而来）
  home-manager.users.xiaoyintx =
    { ... }:
    {
      programs.vscode.userSettings = {
        "workbench.colorCustomizations" = {
          foreground = "#dde4e3";
          focusBorder = "#80d4d7";
          "widget.shadow" = "#00000033";
          "selection.background" = "#80d4d740";
          descriptionForeground = "#bec8c8";
          errorForeground = "#ffb4ab";
          "editor.background" = "#0e1415";
          "editor.foreground" = "#dde4e3";
          editorLineNumber = {
            foreground = "#899393";
            activeForeground = "#80d4d7";
          };
          "editorCursor.foreground" = "#80d4d7";
          "editor.selectionBackground" = "#80d4d740";
          "editor.inactiveSelectionBackground" = "#80d4d715";
          "editor.lineHighlightBackground" = "#1a2121";
          "editor.wordHighlightBackground" = "#b0cccc33";
          "editor.wordHighlightStrongBackground" = "#80d4d733";
          editorBracketMatch = {
            background = "#252b2b";
            border = "#899393";
          };
          editorSuggestWidget = {
            background = "#252b2b";
            border = "#899393";
            foreground = "#dde4e3";
            selectedBackground = "#80d4d7";
            selectedForeground = "#003738";
            highlightForeground = "#80d4d7";
            focusHighlightForeground = "#003738";
          };
          titleBar = {
            activeBackground = "#161d1d";
            activeForeground = "#dde4e3";
            border = "#3f4949";
            inactiveBackground = "#0e1415";
          };
          activityBar = {
            background = "#1a2121";
            foreground = "#80d4d7";
            activeBorder = "#80d4d7";
            inactiveForeground = "#899393";
          };
          activityBarBadge = {
            background = "#80d4d7";
            foreground = "#003738";
          };
          sideBar = {
            background = "#161d1d";
            foreground = "#bec8c8";
            border = "#3f4949";
          };
          sideBarSectionHeader = {
            background = "#1a2121";
          };
          sideBarTitle = {
            foreground = "#80d4d7";
          };
          statusBar = {
            background = "#1a2121";
            foreground = "#dde4e3";
            border = "#3f4949";
            debuggingBackground = "#ffb4ab";
            noFolderBackground = "#1a2121";
          };
          editorGroupHeader = {
            tabsBackground = "#0e1415";
          };
          tab = {
            activeBackground = "#0e1415";
            inactiveBackground = "#161d1d";
            activeForeground = "#80d4d7";
            activeBorderTop = "#80d4d7";
            border = "#3f4949";
          };
          input = {
            background = "#1a2121";
            foreground = "#dde4e3";
            border = "#899393";
            placeholderForeground = "#899393";
          };
          "input.option.activeBorder" = "#80d4d7";
          inputOption = {
            activeBackground = "#80d4d733";
            activeForeground = "#80d4d7";
          };
          inputValidation = {
            errorBackground = "#ffb4ab33";
            errorBorder = "#ffb4ab";
            infoBackground = "#b0cccc33";
            infoBorder = "#b0cccc";
            warningBackground = "#b4c7e933";
            warningBorder = "#b4c7e9";
          };
          editorWidget = {
            background = "#252b2b";
            border = "#899393";
            resizeBorder = "#80d4d7";
          };
          button = {
            background = "#80d4d7";
            foreground = "#003738";
            hoverBackground = "#80d4d7CC";
            secondaryBackground = "#252b2b";
          };
          list = {
            activeSelectionBackground = "#80d4d733";
            activeSelectionForeground = "#80d4d7";
            hoverBackground = "#dde4e310";
            highlightForeground = "#80d4d7";
            focusOutline = "#80d4d7";
          };
          menu = {
            background = "#1a2121";
            foreground = "#dde4e3";
            selectionBackground = "#80d4d7";
            selectionForeground = "#003738";
            border = "#3f4949";
          };
          quickInput = {
            background = "#252b2b";
            foreground = "#dde4e3";
          };
          pickerGroup = {
            border = "#3f4949";
            foreground = "#80d4d7";
          };
          quickInputList = {
            focusBackground = "#80d4d7";
            focusForeground = "#003738";
          };
          panel = {
            background = "#161d1d";
            border = "#3f4949";
          };
          panelTitle = {
            activeBorder = "#80d4d7";
            activeForeground = "#80d4d7";
            inactiveForeground = "#bec8c8";
          };
          terminal = {
            background = "#0e1415";
            foreground = "#dde4e3";
            ansiBlack = "#252b2b";
            ansiRed = "#ffb4ab";
            ansiGreen = "#80d4d7";
            ansiYellow = "#354863";
            ansiBlue = "#80d4d7";
            ansiMagenta = "#b4c7e9";
            ansiCyan = "#b0cccc";
            ansiWhite = "#dde4e3";
            ansiBrightBlack = "#899393";
            ansiBrightRed = "#ffb4ab";
            ansiBrightGreen = "#80d4d7";
            ansiBrightYellow = "#b4c7e9";
            ansiBrightBlue = "#80d4d7";
            ansiBrightMagenta = "#b4c7e9";
            ansiBrightCyan = "#b0cccc";
            ansiBrightWhite = "#dde4e3";
          };
        };
        "editor.tokenColorCustomizations" = {
          textMateRules = [
            {
              scope = [ "comment" "punctuation.definition.comment" ];
              settings = {
                foreground = "#b0cccc99";
                fontStyle = "italic";
              };
            }
            {
              scope = [
                "variable"
                "variable.language"
                "variable.name"
                "variable.other"
                "variable.parameter"
              ];
              settings = {
                foreground = "#80d4d7";
              };
            }
          ];
        };
        "editor.fontFamily" = "'Maple Mono NR NF CN', monospace";
        "editor.fontLigatures" = "'calt'";
        "gitlens.ai.model" = "vscode";
        "gitlens.ai.vscode.model" = "copilot:gpt-4o-mini";
        "editor.quickSuggestions" = {
          other = "on";
          comments = "off";
          strings = "off";
        };
        "editor.allowVariableFontsInAccessibilityMode" = true;
        "git.autofetch" = true;
        "explorer.confirmDelete" = false;
        "markdown-preview-enhanced.enablePreviewZenMode" = true;
        "markdown.extension.completion.enabled" = true;
        "[markdown]" = {
          "editor.defaultFormatter" = "yzhang.markdown-all-in-one";
        };
        "editor.codeActionsOnSave" = {
          "markdown-preview-enhanced.mathRenderingOption" = "MathJax";
        };
        "editor.autoIndentOnPaste" = true;
        "git.enableSmartCommit" = true;
        "terminal.integrated.enableMultiLinePasteWarning" = "never";
        "[jsonc]" = {
          "editor.defaultFormatter" = "vscode.json-language-features";
        };
        "cnblogsClient.linux.workspace" = "/home/xiaoyintx/Documents/cnblogs";
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "prettier.enableDebugLogs" = true;
        "prettier.useTabs" = true;
        "prettier.bracketSameLine" = true;
        "editor.formatOnPaste" = true;
        "prettier.configPath" = "/home/xiaoyintx/prettier/.prettierrc.json";
        "[cpp]" = {
          "editor.defaultFormatter" = "ms-vscode.cpptools";
        };
        "editor.formatOnType" = true;
        "files.autoSave" = "afterDelay";
        "C_Cpp.formatting" = "vcFormat";
        "C_Cpp.vcFormat.newLine.beforeOpenBrace.function" = "sameLine";
        "C_Cpp.vcFormat.newLine.beforeOpenBrace.block" = "sameLine";
        "C_Cpp.vcFormat.newLine.beforeOpenBrace.lambda" = "sameLine";
        "C_Cpp.vcFormat.newLine.beforeOpenBrace.namespace" = "sameLine";
        "C_Cpp.vcFormat.newLine.beforeOpenBrace.type" = "sameLine";
        "C_Cpp.vcFormat.space.insertAfterSemicolon" = true;
        "vscode_custom_css.imports" = [
          "file:///home/xiaoyintx/.vscode/extensions/brandonkirbyson.vscode-animations-2.0.7/dist/updateHandler.js"
        ];
        "window.confirmSaveUntitledWorkspace" = false;
        "animations.UseCursorColorForCursorAnimation" = true;
        "animations.CursorAnimation" = true;
        "animations.CursorAnimationOptions" = {
          TrailLength = 8;
          CursorStyle = "line";
        };
        "cph-ng.languages.cppCompiler" = "/usr/bin/g++";
        "cph-ng.languages.cppCompilerArgs" = "-O2 -std=c++23 -Wall -DCPH";
        "debug.onTaskErrors" = "debugAnyway";
        "github.copilot.enable" = {
          "*" = false;
          plaintext = false;
          markdown = false;
          scminput = false;
        };
        "[rust]" = {
          "editor.defaultFormatter" = "rust-lang.rust-analyzer";
        };
        "rust-analyzer.linkedProjects" = [ ];
        "rust-analyzer.debug.engine" = "ms-vscode.cpptools";
        "rust-analyzer.typing.triggerChars" = null;
        "rust-analyzer.restartServerOnConfigChange" = true;
        "rust-analyzer.cargo.loadOutDirsFromCheck" = true;
        "rust-analyzer.diagnostics.warningsAsHint" = [ "false" ];
        "git.openRepositoryInParentFolders" = "never";
        "C_Cpp.vcFormat.indent.lambdaBracesWhenParameter" = false;
        "editor.formatOnSave" = true;
        "chat.viewSessions.orientation" = "stacked";
        "chat.tools.terminal.autoApprove" = {
          "/^python3 -c \"\nimport numpy as np\nfrom PIL import Image\nimport json\n\n# Simple gradient using numpy\nimg = Image\\.open\\('/home/xiaoyintx/Downloads/2026华北理工大学数学建模校赛竞赛题目/B题/ciallo/top1251\\.tif'\\)\narr = np\\.array\\(img\\)\ngray = np\\.mean\\(arr, axis=2\\)\n\n# Simple Sobel-like gradient\ngx = gray\\[:, 2:\\] - gray\\[:, :-2\\]\ngy = gray\\[2:, :\\] - gray\\[:-2, :\\]\n# Pad to same size\ngx_pad = np\\.zeros_like\\(gray\\)\ngy_pad = np\\.zeros_like\\(gray\\)\ngx_pad\\[:, 1:-1\\] = np\\.abs\\(gx\\)\ngy_pad\\[1:-1, :\\] = np\\.abs\\(gy\\)\nedges = np\\.sqrt\\(gx_pad\\*\\*2 \\+ gy_pad\\*\\*2\\)\n\nrock_mask = gray > 70\nprint\\(f'Rock region edge stats: mean=\\{edges\\[rock_mask\\]\\.mean\\(\\):\\.2f\\}, max=\\{edges\\[rock_mask\\]\\.max\\(\\):\\.2f\\}'\\)\n\n# Dark features in rock \\(potential fractures\\)\n# Fractures are darker than surrounding rock\ndark_in_rock = \\(gray < 100\\) & rock_mask\nprint\\(f'Dark regions in rock: \\{dark_in_rock\\.sum\\(\\)\\} pixels'\\)\n\n# Very dark features \\(definitely fractures or pores\\)\nvery_dark = \\(gray < 80\\) & rock_mask\nprint\\(f'Very dark in rock: \\{very_dark\\.sum\\(\\)\\} pixels'\\)\n\n# Show where fractures might be - darker linear features\n# Use local contrast: diff between pixel and local mean\nfrom scipy import ndimage\n# Try basic box filter\nkernel = np\\.ones\\(\\(15, 15\\)\\) / 225\nlocal_mean = ndimage\\.convolve\\(gray, kernel\\)\nlocal_contrast = gray\\.astype\\(float\\) - local_mean\nprint\\(f'Local contrast \\(15x15\\): mean=\\{local_contrast\\[rock_mask\\]\\.mean\\(\\):\\.2f\\}, std=\\{local_contrast\\[rock_mask\\]\\.std\\(\\):\\.2f\\}'\\)\n# Negative values mean darker than local area \\(potential fractures\\)\nneg_contrast = \\(local_contrast < -15\\) & rock_mask\nprint\\(f'Significantly darker than local \\(fracture candidates\\): \\{neg_contrast\\.sum\\(\\)\\} pixels \\(\\{neg_contrast\\.mean\\(\\)\\*100:\\.2f\\}%\\)'\\)\n\" 2>&1$/" = {
            approve = true;
            matchCommandLine = true;
          };
        };
        "markdown.marp.exportType" = "pptx";
        "security.workspace.trust.untrustedFiles" = "open";
        "C_Cpp.default.compilerPath" = "/usr/bin/g++/";
        "C_Cpp.default.cppStandard" = "gnu++23";
        "C_Cpp.default.intelliSenseMode" = "linux-gcc-x64";
        "chat.utilityModel" = "deepseek/deepseek-v4-flash";
        "chat.utilitySmallModel" = "deepseek/deepseek-v4-flash";
        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
        };
        "[lua]" = {
          "editor.defaultFormatter" = "sumneko.lua";
        };
        "vscode-office.codeMirrorTheme" = "One Dark";
        "editor.fontSize" = 16;
        "workbench.experimental.modernUI" = false;
      };
    };
}