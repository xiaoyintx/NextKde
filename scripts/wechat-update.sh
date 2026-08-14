#!/usr/bin/env bash
# =====================================================================
# 微信 Linux 版 新版本 hash 检测器
#
# 背景：微信的官方 Linux 直链是「滚动最新版」URL，文件名不带版本号：
#   https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.AppImage
# 腾讯一发布新版本，该 URL 的内容就会变化，因此无法靠文件名判断版本，
# 只能靠「内容 hash」来识别。本脚本会：
#   1. 从国内 CDN 重新下载最新 AppImage（或直接读 nix 缓存里的文件）
#   2. 计算其 sha256 并转换为 Nix 的 SRI 格式
#   3. 从 AppImage 中提取真实版本号
#   4. 与 wechat.nix 中锁定的 hash 比对：
#        - 一致 → 当前已是最新
#        - 不一致 → 检测到新版本，输出新的 hash/版本，粘贴回 wechat.nix
#
# 用法：
#   bash scripts/wechat-update.sh            # 下载最新文件并检测
#   bash scripts/wechat-update.sh --force    # 强制重新下载（不读缓存）
# =====================================================================
set -euo pipefail

URL="https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.AppImage"
# 与 software/wechat.nix 中锁定的 hash 保持一致
PINNED_HASH="sha256-RX26ArkbAxzdRBLu4HT7v/udnQax5Q/Bgi00hw4RSZA="

# ---- 1. 获取最新文件 ------------------------------------------------
# 优先用 nix-prefetch-url：有缓存则秒出，否则走国内 CDN 下载。
# 注意：store 路径打印在 stderr（"path is '...'"），stdout 是 hash。
FETCH=()
if [[ "${1:-}" != "--force" ]]; then
  FETCH=(--type sha256)
fi
echo "==> 从国内 CDN 获取最新 AppImage ..."
PREFETCH_OUT=$(nix-prefetch-url "${FETCH[@]}" "$URL" 2>&1)
STORE_PATH=$(printf '%s\n' "$PREFETCH_OUT" | sed -n "s/^path is '\(.*\)'/\1/p" | head -1)
if [[ -z "$STORE_PATH" ]]; then
  echo "错误：无法解析 nix-prefetch-url 的输出。" >&2
  printf '%s\n' "$PREFETCH_OUT" >&2
  exit 1
fi
echo "    store 文件: $STORE_PATH"

# ---- 2. 计算并转换 SRI hash ------------------------------------------
HEX=$(sha256sum "$STORE_PATH" | awk '{print $1}')
SRI=$(nix --extra-experimental-features nix-command hash convert \
       --hash-algo sha256 --to sri --from hex "$HEX" 2>/dev/null \
   || nix --extra-experimental-features nix-command hash to-sri --type sha256 "$HEX")
echo "    sha256 (SRI): $SRI"

# ---- 3. 提取真实版本号 ------------------------------------------------
# 从 AppImage 内嵌 squashfs 的 .desktop 拿权威版本号 X-AppImage-Version。
# 需要 unsquashfs。
VERSION=""
EXTRACT_OK=""
TMPDIR_X=""
if command -v unsquashfs >/dev/null 2>&1 || nix --extra-experimental-features 'nix-command flakes' \
     shell nixpkgs#squashfsTools -c 'true' >/dev/null 2>&1; then
  TMPDIR_X=$(mktemp -d)
  trap 'rm -rf "$TMPDIR_X"' EXIT
  # 逐个偏移尝试，取第一个能解开的 squashfs（AppImage 头部带有运行时会话数据）
  for OFF in $(grep -aob 'hsqs' "$STORE_PATH" | cut -d: -f1); do
    if nix --extra-experimental-features 'nix-command flakes' shell nixpkgs#squashfsTools -c \
        unsquashfs -offset "$OFF" -d "$TMPDIR_X" "$STORE_PATH" >/dev/null 2>&1; then
      EXTRACT_OK=1
      break
    fi
  done
  if [[ -n "$EXTRACT_OK" ]]; then
    V3=$(grep -m1 'X-AppImage-Version' "$TMPDIR_X/wechat.desktop" 2>/dev/null | cut -d= -f2)
    # 优先用 .desktop 里的 X-AppImage-Version（权威可靠）；ELF 里的第 4 段版本不可靠，仅作兜底
    VERSION="${V3:-}"
    echo "    检测版本号: ${VERSION:-（无法提取）}"
  fi
fi

# ---- 4. 与新版本比对 ------------------------------------------------
echo ""
if [[ "$SRI" == "$PINNED_HASH" ]]; then
  echo "✔ 当前已是最新版本（hash 未变化），无需更新。"
else
  echo "✖ 检测到新版本！需要更新 software/wechat.nix："
  echo "    wechatVersion = \"${VERSION:-<新版本>}\";"
  echo "    hash         = \"$SRI\";"
  echo ""
  echo "  提示：也可直接跑  nix build .#wechat 触发 hash mismatch 拿到新 hash。"
fi
