# ZaraPPT 风格模板

> ZaraPPT 是面向前端技术分享的轻量级 PPT 风格，提供 12 种视觉预设和现代化的交互动画。

## 风格定位

| 维度 | 描述 |
|------|------|
| 适用场景 | 前端技术分享、前端大会演讲、代码演示 |
| 视觉特征 | 现代化、代码友好、动画丰富 |
| 预设数量 | 12 种风格预设 |
| 动画支持 | CSS entrance + background + interactive |

## 核心 CSS 变量

```css
:root {
  /* 通用视口参数 */
  --slide-width: 1280px;
  --slide-height: 720px;
  --viewport-fit: auto;

  /* 字号体系 */
  --font-title: clamp(24px, 4vw, 48px);
  --font-subtitle: clamp(16px, 2.5vw, 28px);
  --font-body: clamp(12px, 1.8vw, 20px);
  --font-code: clamp(10px, 1.4vw, 16px);
  --font-note: clamp(8px, 1.2vw, 14px);
}
```

## 视口适配规则

viewport-base.css 提供了强制性的视口适配，必须引入：

```html
<link rel="stylesheet" href="refs/zarappt/zarappt-viewport.css">
```

### 响应式断点

| 断点 | 宽度范围 | 字号策略 |
|------|---------|---------|
| 900px+ | 大屏/投影 | 固定字号，100% scale |
| 700px | 笔记本 | 90% scale |
| 600px | 小笔记本 | 85% scale |
| 500px | 平板/手机 | 75% scale，竖屏警告 |

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

### 使用方式

```html
<!-- 入口动画：slide in from left -->
<div class="anim-slide-in">内容</div>

<!-- 背景动画：gradient shift -->
<div class="anim-gradient-shift">背景</div>

<!-- 交互：hover 放大 -->
<div class="anim-hover-zoom">可交互元素</div>
```

## 视差滚动幻灯片

ZaraPPT 支持基于 scroll 的视差幻灯片：

```javascript
const presentation = new SlidePresentation({
  scrollContainer: document.getElementById('scroll-container'),
  slideCount: 10,
  useParallax: true,
  parallaxStrength: 0.3
});
```

## 代码高亮

使用 Prism.js 风格的代码高亮：

```html
<pre><code class="language-javascript">const fn = () => 'code';</code></pre>
```

## 快捷键

| 键 | 功能 |
|----|------|
| `←` `→` | 上下翻页 |
| `Space` | 下一页 |
| `Home` `End` | 首页/末页 |
| `Esc` | 退出全屏 |
| `P` | 演讲者模式 |

## 导出与部署

详见 ppt-forge/ppt-delivery.md

- **HTML 单文件**：reveal.js 封装所有 slides
- **PPTX 导出**：python-pptx 转换脚本
- **PDF 导出**：Playwright 渲染脚本
- **在线部署**：Vercel 一键部署脚本

## 与 ppt-forge 的整合

ZaraPPT 作为 ppt-forge 的品牌模板层：

1. **P 阶段**：选择 zarappt 作为品牌
2. **S 阶段**：从 12 种预设中选择风格
3. **A 阶段**：使用 viewport CSS + 动画系统制作
4. **R 阶段**：按预设风格审查
5. **E/D 阶段**：导出 HTML/PPTX 单文件交付
