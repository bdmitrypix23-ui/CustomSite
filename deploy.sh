#!/bin/bash
# deploy.sh — пушит index.html в CustomSite → GitHub Pages
# Использование: ./deploy.sh "Описание что задеплоено"
# Или без аргумента: ./deploy.sh

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
MSG="${1:-Deploy: update}"

cd "$REPO_DIR"

git config user.email "deploy@customsite.local" 2>/dev/null || true
git config user.name "Claude Deploy" 2>/dev/null || true

git pull --rebase origin main --quiet 2>/dev/null || true

git add index.html

if git diff --cached --quiet; then
  echo "⚠ Нечего коммитить — файл не изменился"
  exit 0
fi

git commit -m "$MSG" --quiet
git push origin main --quiet

echo "✅ Задеплоено: https://bdmitrypix23-ui.github.io/CustomSite"
echo "   Обновится через ~60 сек (GitHub Pages)"
