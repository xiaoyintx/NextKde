{
  # vscode userSettings（从 gitee settings.json 迁移而来）
  home-manager.users.xiaoyintx =
    { ... }:
    {
      programs.vscode.profiles.default.userSettings = {
        "workbench.colorCustomizations" = {
          foreground = "#dde4e3";
          focusBorder = "#80d4d7";
          "widget.shadow" = "#00000033";
          "selection.background" = "#80d4d740";
          descriptionForeground = "#bec8c8";
          errorForeground = "#ffb4ab";
          "editor.background" = "#0e1415";
          "editor.foreground" = "#dde4e3";
          "editorLineNumber.foreground" = "#899393";
          "editorLineNumber.activeForeground" = "#80d4d7";
          "editorCursor.foreground" = "#80d4d7";
          "editor.selectionBackground" = "#80d4d740";
          "editor.inactiveSelectionBackground" = "#80d4d715";
          "editor.lineHighlightBackground" = "#1a2121";
          "editor.wordHighlightBackground" = "#b0cccc33";
          "editor.wordHighlightStrongBackground" = "#80d4d733";
          "editorBracketMatch.background" = "#252b2b";
          "editorBracketMatch.border" = "#899393";
          "editorSuggestWidget.background" = "#252b2b";
          "editorSuggestWidget.border" = "#899393";
          "editorSuggestWidget.foreground" = "#dde4e3";
          "editorSuggestWidget.selectedBackground" = "#80d4d7";
          "editorSuggestWidget.selectedForeground" = "#003738";
          "editorSuggestWidget.highlightForeground" = "#80d4d7";
          "editorSuggestWidget.focusHighlightForeground" = "#003738";
          "titleBar.activeBackground" = "#161d1d";
          "titleBar.activeForeground" = "#dde4e3";
          "titleBar.border" = "#3f4949";
          "titleBar.inactiveBackground" = "#0e1415";
          "activityBar.background" = "#1a2121";
          "activityBar.foreground" = "#80d4d7";
          "activityBar.activeBorder" = "#80d4d7";
          "activityBar.inactiveForeground" = "#899393";
          "activityBarBadge.background" = "#80d4d7";
          "activityBarBadge.foreground" = "#003738";
          "sideBar.background" = "#161d1d";
          "sideBar.foreground" = "#bec8c8";
          "sideBar.border" = "#3f4949";
          "sideBarSectionHeader.background" = "#1a2121";
          "sideBarTitle.foreground" = "#80d4d7";
          "statusBar.background" = "#1a2121";
          "statusBar.foreground" = "#dde4e3";
          "statusBar.border" = "#3f4949";
          "statusBar.debuggingBackground" = "#ffb4ab";
          "statusBar.noFolderBackground" = "#1a2121";
          "editorGroupHeader.tabsBackground" = "#0e1415";
          "tab.activeBackground" = "#0e1415";
          "tab.inactiveBackground" = "#161d1d";
          "tab.activeForeground" = "#80d4d7";
          "tab.activeBorderTop" = "#80d4d7";
          "tab.border" = "#3f4949";
          "input.background" = "#1a2121";
          "input.foreground" = "#dde4e3";
          "input.border" = "#899393";
          "input.placeholderForeground" = "#899393";
          "input.option.activeBorder" = "#80d4d7";
          "inputOption.activeBackground" = "#80d4d733";
          "inputOption.activeForeground" = "#80d4d7";
          "inputValidation.errorBackground" = "#ffb4ab33";
          "inputValidation.errorBorder" = "#ffb4ab";
          "inputValidation.infoBackground" = "#b0cccc33";
          "inputValidation.infoBorder" = "#b0cccc";
          "inputValidation.warningBackground" = "#b4c7e933";
          "inputValidation.warningBorder" = "#b4c7e9";
          "editorWidget.background" = "#252b2b";
          "editorWidget.border" = "#899393";
          "editorWidget.resizeBorder" = "#80d4d7";
          "button.background" = "#80d4d7";
          "button.foreground" = "#003738";
          "button.hoverBackground" = "#80d4d7CC";
          "button.secondaryBackground" = "#252b2b";
          "list.activeSelectionBackground" = "#80d4d733";
          "list.activeSelectionForeground" = "#80d4d7";
          "list.hoverBackground" = "#dde4e310";
          "list.highlightForeground" = "#80d4d7";
          "list.focusOutline" = "#80d4d7";
          "menu.background" = "#1a2121";
          "menu.foreground" = "#dde4e3";
          "menu.selectionBackground" = "#80d4d7";
          "menu.selectionForeground" = "#003738";
          "menu.border" = "#3f4949";
          "quickInput.background" = "#252b2b";
          "quickInput.foreground" = "#dde4e3";
          "pickerGroup.border" = "#3f4949";
          "pickerGroup.foreground" = "#80d4d7";
          "quickInputList.focusBackground" = "#80d4d7";
          "quickInputList.focusForeground" = "#003738";
          "panel.background" = "#161d1d";
          "panel.border" = "#3f4949";
          "panelTitle.activeBorder" = "#80d4d7";
          "panelTitle.activeForeground" = "#80d4d7";
          "panelTitle.inactiveForeground" = "#bec8c8";
          "terminal.background" = "#0e1415";
          "terminal.foreground" = "#dde4e3";
          "terminal.ansiBlack" = "#252b2b";
          "terminal.ansiRed" = "#ffb4ab";
          "terminal.ansiGreen" = "#80d4d7";
          "terminal.ansiYellow" = "#354863";
          "terminal.ansiBlue" = "#80d4d7";
          "terminal.ansiMagenta" = "#b4c7e9";
          "terminal.ansiCyan" = "#b0cccc";
          "terminal.ansiWhite" = "#dde4e3";
          "terminal.ansiBrightBlack" = "#899393";
          "terminal.ansiBrightRed" = "#ffb4ab";
          "terminal.ansiBrightGreen" = "#80d4d7";
          "terminal.ansiBrightYellow" = "#b4c7e9";
          "terminal.ansiBrightBlue" = "#80d4d7";
          "terminal.ansiBrightMagenta" = "#b4c7e9";
          "terminal.ansiBrightCyan" = "#b0cccc";
          "terminal.ansiBrightWhite" = "#dde4e3";
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