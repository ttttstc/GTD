#!/bin/bash
# ZaraPPT PDF 导出脚本
#
# 使用方式：
#   ./zarappt-export-pdf.sh input.html                    # 输出 input.pdf
#   ./zarappt-export-pdf.sh input.html output.pdf         # 自定义输出
#   ./zarappt-export-pdf.sh input.html --slides 1,3,5     # 导出特定页
#
# 依赖：
#   - Playwright: npx playwright install chromium

set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 默认值
INPUT_FILE=""
OUTPUT_FILE=""
SELECTED_SLIDES=""

# 参数解析
while [[ $# -gt 0 ]]; do
    case $1 in
        --slides)
            SELECTED_SLIDES="$2"
            shift 2
            ;;
        -o|--output)
            OUTPUT_FILE="$2"
            shift 2
            ;;
        *.html)
            INPUT_FILE="$1"
            shift
            ;;
        *)
            echo -e "${RED}未知参数: $1${NC}"
            exit 1
            ;;
    esac
done

# 检查 Playwright
check_playwright() {
    if ! command -v npx &> /dev/null; then
        echo -e "${RED}错误：需要 npm/npx${NC}"
        exit 1
    fi

    if ! npx playwright --version &> /dev/null 2>&1; then
        echo -e "${YELLOW}安装 Playwright...${NC}"
        npm install -D playwright
        npx playwright install chromium
    fi
}

# 转换函数
convert_to_pdf() {
    local input="$1"
    local output="$2"
    local slides="$3"

    # 生成临时 JS 脚本
    local tmp_script=$(mktemp --suffix=.js)
    cat > "$tmp_script" << 'SCRIPT'
const { chromium } = require('playwright');
const path = require('path');
const fs = require('fs');

async function exportPDF(inputFile, outputFile, slides) {
    const browser = await chromium.launch();
    const context = await browser.newContext();
    const page = await context.newPage();

    // 加载 HTML 文件
    const filePath = 'file://' + path.resolve(inputFile);
    await page.goto(filePath, { waitUntil: 'networkidle' });

    // 等待内容加载
    await page.waitForTimeout(1000);

    // 导出 PDF
    const pdfOptions = {
        path: outputFile,
        format: 'A4',
        landscape: true,
        printBackground: true
    };

    await page.pdf(pdfOptions);
    await browser.close();
    console.log('PDF 已导出:', outputFile);
}

const [,, inputFile, outputFile] = process.argv;
exportPDF(inputFile, outputFile);
SCRIPT

    # 执行转换
    npx playwright test --browser=chromium "$tmp_script" 2>/dev/null || \
        node "$tmp_script" "$inputFile" "$outputFile"

    rm -f "$tmp_script"
}

# 主流程
echo -e "${GREEN}ZaraPPT PDF 导出${NC}"
echo "===================="

# 检查输入文件
if [ -z "$INPUT_FILE" ]; then
    echo -e "${RED}错误：未指定输入文件${NC}"
    echo "用法: $0 input.html [output.pdf]"
    exit 1
fi

if [ ! -f "$INPUT_FILE" ]; then
    echo -e "${RED}错误：文件不存在 $INPUT_FILE${NC}"
    exit 1
fi

# 生成输出文件名
if [ -z "$OUTPUT_FILE" ]; then
    OUTPUT_FILE="${INPUT_FILE%.html}.pdf"
fi

echo -e "${GREEN}输入: $INPUT_FILE${NC}"
echo -e "${GREEN}输出: $OUTPUT_FILE${NC}"

# 检查 Playwright
check_playwright

# 执行转换
echo -e "${YELLOW}正在转换为 PDF...${NC}"
convert_to_pdf "$INPUT_FILE" "$OUTPUT_FILE" "$SELECTED_SLIDES"

echo ""
echo -e "${GREEN}完成！${NC}"
