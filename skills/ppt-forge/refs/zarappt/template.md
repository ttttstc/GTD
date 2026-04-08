# ZaraPPT 风格模板

> ZaraPPT 是面向前端技术分享的轻量级 PPT 风格，提供 12 种视觉预设和现代化的交互动画。
> 基于 frontend-slides 核心原则：Zero-dependency 单文件 HTML + 强制视口适配 + SlidePresentation JS 类。

## 核心原则（来自 frontend-slides）

**这些原则是 ZaraPPT 的基础，必须遵守：**

| 原则 | 说明 | 必须遵守 |
|------|------|---------|
| Zero-dependency | 单 HTML 文件，内联 CSS/JS，无 npm 无构建工具 | ✅ |
| Viewport Fitting | 每个 `.slide` 必须精确适配 100vh，禁止 slide 内滚动 | ✅ |
| Fontshare/Google Fonts | 必须用在线字体，禁止系统字体 | ✅ |
| clamp() 字号 | 所有字号必须用 `clamp(min, preferred, max)` | ✅ |
| .visible 动画触发 | 动画通过 IntersectionObserver 添加 `.visible` 类触发 | ✅ |

## 风格定位

| 维度 | 描述 |
|------|------|
| 适用场景 | 前端技术分享、前端大会演讲、代码演示 |
| 视觉特征 | 现代化、代码友好、动画丰富 |
| 预设数量 | 12 种风格预设 |
| 动画支持 | CSS entrance + background + interactive |
| 渲染架构 | 滚动驱动（scroll-snap） |

## 视口适配规则（强制性）

详见 `zarappt-viewport.css` —— 每个 `.slide` 必须包含：

```css
.slide {
    width: 100vw;
    height: 100vh;
    height: 100dvh; /* 动态视口高度，适配移动端浏览器 */
    overflow: hidden; /* 关键：禁止 slide 内滚动 */
    scroll-snap-align: start;
}
```

**违反视口规则 = 布局 bug，必须修复。**

## 字体规范

**禁止使用系统字体**，必须使用 Fontshare 或 Google Fonts：

| 预设 | Display Font | Body Font | 来源 |
|------|-------------|-----------|------|
| Bold Signal | Archivo Black | Space Grotesk | Google |
| Electric Studio | Manrope | Manrope | Google |
| Creative Voltage | Syne | Space Mono | Google |
| Dark Botanical | Cormorant | IBM Plex Sans | Google |
| Terminal Green | JetBrains Mono | JetBrains Mono | JetBrains |
| Swiss Modern | Archivo | Nunito | Google |
| ... | ... | ... | ... |

## 12 种视觉预设

详见 `zarappt-presets.md`

### 预设速查

| 编号 | 预设名 | 关键词 | 适用场景 |
|------|--------|--------|---------|
| 1 | Bold Signal | 粗体、信号色 | 技术公告、产品发布 |
| 2 | Electric Studio | 电光、渐变 | 创意展示 |
| 3 | Creative Voltage | 创意电压、高饱和 | 头脑风暴 |
| 4 | Dark Botanical | 暗黑、植物纹理 | 神秘感主题 |
| 5 | Notebook Tabs | 笔记本标签 | 笔记风格 |
| 6 | Pastel Geometry | 粉彩、几何 | 柔和演示 |
| 7 | Split Pastel | 分屏粉彩 | 对比展示 |
| 8 | Vintage Editorial | 复古编辑 | 历史回顾 |
| 9 | Neon Cyber | 霓虹赛博 | 科技感 |
| 10 | Terminal Green | 终端绿 | 代码主题 |
| 11 | Swiss Modern | 瑞士现代 | 极简专业 |
| 12 | Paper & Ink | 纸墨 | 文档风格 |

## 动画系统

详见 `zarappt-animation.md`

### 三大动画类型

1. **Entrance Animations** — 进入动画（slide in, fade in, scale up）
2. **Background Effects** — 背景动效（gradient shift, particle）
3. **Interactive Effects** — 交互反馈（hover, click, keyboard）

### .visible 触发机制

动画通过 IntersectionObserver 添加 `.visible` 类触发：

```css
.reveal {
    opacity: 0;
    transform: translateY(30px);
    transition: opacity 0.6s ease-out, transform 0.6s ease-out;
}

.slide.visible .reveal {
    opacity: 1;
    transform: translateY(0);
}
```

## HTML 架构规范

详见 `html-template.md` —— 完整的 HTML 模板和 SlidePresentation JS 类。

### SlidePresentation JS 类功能

- 键盘导航（方向键、Space、Page Up/Down）
- 触摸/滑动支持
- 滚动进度条
- 导航点

## 导出与部署

详见 ppt-forge/ppt-delivery.md

- **HTML 单文件**：reveal.js 封装所有 slides（不推荐，优先用原生滚动）
- **PPTX 导出**：python-pptx 转换脚本
- **PDF 导出**：Playwright 渲染脚本
- **在线部署**：Vercel 一键部署脚本

## 与 ppt-forge 的整合

ZaraPPT 作为 ppt-forge 的品牌模板层：

1. **P 阶段**：选择 zarappt 作为品牌
2. **S 阶段**：从 12 种预设中选择风格
3. **A 阶段**：使用 viewport CSS + 动画系统 + SlidePresentation JS
4. **R 阶段**：按预设风格审查（视口、字体、动画触发）
5. **E/D 阶段**：导出 HTML/PPTX 单文件交付
