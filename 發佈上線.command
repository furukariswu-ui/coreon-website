#!/bin/bash
# COREON 官網 — 雙擊發佈到 GitHub（Cloudflare Pages 會自動重新部署）
#
# 這個資料夾在 Desktop 裡，很可能被 iCloud Drive 同步，Git 在 iCloud 同步的資料夾裡
# 常常會卡在 lock 檔案（這是很多 Mac 使用者都遇過的已知問題，不是你的檔案壞掉了）。
# 所以這個腳本會先把網站檔案「複製」到家目錄下一個不會被 iCloud 同步的資料夾，
# 真正的 Git 動作都在那邊做，你只需要繼續在這裡（Cowork 資料夾）編輯內容就好。

SRC="$(cd "$(dirname "$0")" && pwd)"
GITDIR="$HOME/coreon-website-git"

echo "同步網站檔案到本機 Git 資料夾..."
mkdir -p "$GITDIR"
rsync -a --delete \
  --exclude ".git" \
  --exclude ".DS_Store" \
  "$SRC/" "$GITDIR/"

cd "$GITDIR" || { echo "❌ 找不到 $GITDIR"; read -p "按 Enter 鍵關閉..."; exit 1; }

# 讓 macOS 鑰匙圈記住登入資訊，第一次輸入 token 成功後之後就不用再輸入
git config --global credential.helper osxkeychain

if [ ! -d .git ]; then
  echo "第一次執行，初始化 Git..."
  git init -q
  git branch -M main
  git remote add origin https://github.com/furukariswu-ui/coreon-website.git
fi

git add -A

if git diff --cached --quiet; then
  echo "沒有新的變更，直接嘗試推送..."
else
  git commit -m "更新網站 $(date '+%Y-%m-%d %H:%M')"
fi

echo "推送到 GitHub..."
if git push -u origin main; then
  echo ""
  echo "✅ 發佈完成！Cloudflare Pages 大約 1-2 分鐘後會自動更新網站。"
else
  echo ""
  echo "❌ 推送失敗，請把上面紅字的錯誤訊息截圖給 Claude 看。"
fi

echo ""
read -p "按 Enter 鍵關閉這個視窗..."
