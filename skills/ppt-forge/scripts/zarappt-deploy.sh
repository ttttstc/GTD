#!/bin/bash
# ZaraPPT Vercel 部署脚本
#
# 使用方式：
#   ./zarappt-deploy.sh                      # 交互式
#   ./zarappt-deploy.sh my-ppt "项目名"       # 自动化
#
# 前置条件：
#   - 安装 Vercel CLI: npm i -g vercel
#   - 已登录 Vercel: vercel login

set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 默认值
PROJECT_NAME="${2:-zarappt-slides}"
INPUT_DIR="${1:-.}"

echo -e "${GREEN}ZaraPPT 部署脚本${NC}"
echo "===================="

# 检查 Vercel CLI
if ! command -v vercel &> /dev/null; then
    echo -e "${YELLOW}Vercel CLI 未安装，正在安装...${NC}"
    npm i -g vercel
fi

# 检查输入目录
if [ ! -d "$INPUT_DIR" ]; then
    echo -e "${RED}错误：目录不存在 $INPUT_DIR${NC}"
    exit 1
fi

# 查找 HTML 文件
HTML_FILES=$(find "$INPUT_DIR" -maxdepth 1 -name "*.html" -type f 2>/dev/null | wc -l)
if [ "$HTML_FILES" -eq 0 ]; then
    echo -e "${RED}错误：在 $INPUT_DIR 中未找到 HTML 文件${NC}"
    exit 1
fi

echo -e "${GREEN}找到 $HTML_FILES 个 HTML 文件${NC}"

# 部署
echo -e "${YELLOW}开始部署到 Vercel...${NC}"
cd "$INPUT_DIR"

if [ -n "$2" ]; then
    # 自动化模式
    vercel --prod --yes --name "$PROJECT_NAME"
else
    # 交互模式
    vercel --prod
fi

echo ""
echo -e "${GREEN}部署完成！${NC}"
echo "===================="
