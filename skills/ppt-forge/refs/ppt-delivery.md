# PPT Delivery — 交付流程

> E 场景（导出/组装）+ D 场景（交付）的执行细节。
> 触发：视觉审查 (R) 通过后。

## 核心原则

**交付不是"文件丢过去"，是"让用户看到效果"。**

- 用户不应该需要找文件、手动打开
- 交付 = 直接可用的单文件 + 说明
- HTML 单文件用 browser-preview 打开；PPTX 单文件直接交付路径

## 输出格式选择

开局参数中声明输出格式后，按以下方式生成：

| 格式 | 生成方式 | 文件特征 |
|------|---------|---------|
| **HTML 单文件** | 将所有 slide 的 HTML 代码组装为一个 reveal.js 单文件 | `topic-slug.html`，浏览器直接打开 |
| **PPTX 单文件** | 用 python-pptx 或 html2pptx 转换工具生成 | `topic-slug.pptx`，PowerPoint/WPS 打开 |
| 分页 HTML | 每个 slide 一个文件（仅审查阶段用） | `01.html`, `02.html`... |

## E: 导出/组装

### HTML 单文件组装

将所有 slide 组装为一个 reveal.js 单文件：

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reveal.js@4.6.1/dist/reveal.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reveal.js@4.6.1/dist/theme/white.min.css">
  <style>
    /* 品牌 CSS 变量（从开局参数获取） */
    :root {
      --brand-primary: #C7020E;
      --brand-secondary: #A50000;
      --brand-dark: #1A1A1A;
      /* ... 其他变量 */
    }
    /* 每个 slide 的完整 CSS */
    .slide-css { ... }
  </style>
</head>
<body>
  <div class="reveal">
    <div class="slides">
      <!-- slide 1 -->
      <section>
        <div class="slide-content">
          <!-- slide HTML 代码 -->
        </div>
      </section>
      <!-- slide 2 -->
      <section>
        <div class="slide-content">
          <!-- slide HTML 代码 -->
        </div>
      </section>
      <!-- 更多 slides -->
    </div>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/reveal.js@4.6.1/dist/reveal.min.js"></script>
  <script>
    Reveal.initialize({
      width: 1280,
      height: 720,
      controls: true,
      progress: true,
      transition: 'slide'
    });
  </script>
</body>
</html>
```

**关键点：**
- 所有 slide 的 CSS 提取合并到 `<style>` 中
- 每个 slide 放在 `<section>` 标签内
- 统一使用 Reveal.js 的 1280×720 视口

### PPTX 单文件生成

使用 `python-pptx` 生成：

```python
from pptx import Presentation
from pptx.util import Inches, Pt

prs = Presentation()
prs.slide_width = Inches(13.333)  # 16:9
prs.slide_height = Inches(7.5)

for slide_html in slides:
    # 将 HTML slide 转换为 PPTX slide
    # 关键：字号换算 CSS_px × 0.75 = PPTX_pt
    slide = prs.slides.add_slide(prs.slide_layouts[6])  # 空白布局
    # 添加文本框、图片等元素...
```

**字号换算参考：**

| CSS px | PPTX pt | 用途 |
|--------|---------|------|
| 22-26px | 16-20pt | L1 标题 |
| 12-14px | 9-11pt | L2 副标题 |
| 10-12px | 7.5-9pt | L3 正文 |
| 8-9px | 6-7pt | L4 辅助 |
| 7-8px | 5-6pt | L5 脚注 |

**PPTX 生成脚本位置：** `scripts/html-to-pptx.py`

## D: 交付

### HTML 单文件交付

```
1. 用 browser-preview skill 打开 HTML 文件到 workspace 浏览器
2. 发消息给用户：
   - 文件路径
   - 关键指标（slide 数、密度数据）
   - 审查结果摘要
3. 等用户确认
```

### PPTX 单文件交付

```
1. 确认文件生成成功
2. 发消息给用户：
   - 文件路径
   - slide 数量
   - 关键指标
3. 等用户确认
```

### 消息模板

```markdown
## PPT 交付

**文件**：`{filename}.{html|pptx}`
**格式**：[HTML 单文件 / PPTX 单文件]
**Slide 数**：N
**品牌**：[华为 / Apple / 通用]
**密度**：[高 / 中 / 低]

[如为 HTML] 预览已开到 workspace 浏览器。
[如为 PPTX] 可直接用 PowerPoint/WPS 打开文件。

请确认或提修改意见。
```

## 用户反馈处理

| 反馈 | 处理 |
|------|------|
| "可以" / "不错" | 交付完成 |
| "这里改一下" | 回 A 阶段修改对应 slide，重新组装 |
| "方向不对" | STOP，回 P 阶段重新规划 |
| "要 HTML 版" | 重新组装 HTML 单文件 |
| "要 PPTX 版" | 重新生成 PPTX 单文件 |

## Common Mistakes

| 错误 | 后果 | 修复 |
|------|------|------|
| 生成多个 HTML 文件而非单文件 | 用户需要逐个打开 | 组装为 reveal.js 单文件 |
| PPTX 字号换算错误 | 文字太小或太大 | 按 0.75 系数换算 |
| 没开 browser-preview | 用户要自己找文件 | 强制 browser-preview |
| 没等确认就结束 | 方向偏了不知道 | 交付必须等确认 |
