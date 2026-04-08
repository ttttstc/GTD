# PPT 风格定调 — S 场景详细流程

> 目的：先做 1-2 张核心页定调 CSS 基线，审过再批量生产。

## 原则

**先定调再批量，避免全做完再返工。**

核心页 = 封面 + 最复杂的内容页。这两页定义了整套 PPT 的视觉基因。

## 触发条件

- P 场景（内容规划）的大纲已确认
- 开局参数（品牌/受众/场景/观看方式）已声明

## 流程

### 1. Author 制作 2 张核心页

- **封面**：标题 + 副标题 + 品牌色 + 日期/署名
- **最复杂内容页**：双列/多元素混合布局，能体现密度上限

### 2. 提取 CSS 变量

从核心页中提炼出可复用的设计 token：

```css
:root {
  --brand-primary: #c7020e;    /* 品牌主色 */
  --brand-secondary: #1a1a1a;  /* 深色 */
  --bg-slide: #ffffff;
  --bg-card: #fafafa;
  --text-title: 18px;
  --text-body: 10px;
  --text-caption: 8px;
  --gap-tight: 2px;
  --gap-normal: 4px;
  --padding-card: 4px 6px;
  --radius-card: 0px;          /* 视品牌而定 */
}
```

### 3. Review 审定风格

Review 审查核心页，确认：
- [ ] 品牌色正确
- [ ] 字体层级合理（标题/正文/标注）
- [ ] 卡片/模块风格统一
- [ ] 整体氛围匹配目标品牌
- [ ] 观看方式适配（大屏字够大 / PDF 密度够高）

### 4. 输出：Style Tile

确认后产出一个 Style Tile 文档，包含：
- 品牌色板
- 字体层级表
- 间距/圆角规范
- 图标风格约定（线框 or 面性）
- 参考截图

### 5. 进入 A 场景

Style Tile 确认后，Author 按确定的 CSS 变量批量制作剩余 slide。

## 常见风格差异速查

| 维度 | 华为 | ZaraPPT | Apple | 阿里 | 通用 |
|------|------|---------|-------|------|------|
| 主色 | 红/黑/灰 | 12种预设可选 | 黑/白/渐变 | 橙/科技蓝 | 可配置 |
| 圆角 | 直角（0px） | 按预设变化 | 大圆角（12-16px） | 中圆角（8px） | 可配置 |
| 密度 | 高（模块化 Boxy） | 中等 | 极低（每页一件事） | 中高（Dashboard） | 可配置 |
| 字重 | 粗体标语 + 细体数据 | 按预设变化 | 超大超粗标题 | 中等偏细 | 可配置 |
| 图标 | 面性/实心 | 几何/简约 | 线框/SF Symbols | Ant Design 线框 | 可配置 |
| 留白 | 最小化 | 中等 | 最大化 | 适度 | 可配置 |
| 字体 | HarmonyOS Sans | Fontshare/Google Fonts | SF Pro | 阿里巴巴普惠体 | 可配置 |
| 动画 | 简单过渡 | 丰富（entrance/bg/interactive） | 微妙 | 适度 | 可配置 |

### ZaraPPT 预设风格速查

| 预设 | 主色 | 背景 | 字体 |
|------|------|------|------|
| Bold Signal | #FF5722 | 深黑渐变 | Archivo Black + Space Grotesk |
| Electric Studio | #4361ee | 深蓝黑 | Manrope |
| Creative Voltage | #0066ff | 深蓝黑 | Syne + Space Mono |
| Dark Botanical | #2D5A3D | 深墨绿 | Cormorant + IBM Plex Sans |
| Notebook Tabs | #E8857B | 米白 | Bodoni Moda + DM Sans |
| Pastel Geometry | #A8D8EA | 象牙白 | Plus Jakarta Sans |
| Split Pastel | #B5EAD7 | 暖白 | Outfit |
| Vintage Editorial | #8B4513 | 羊皮纸 | Fraunces + Work Sans |
| Neon Cyber | #00FFF0 | 纯黑 | Clash Display + Satoshi |
| Terminal Green | #00FF00 | 纯黑 | JetBrains Mono |
| Swiss Modern | #E63946 | 纯白 | Archivo + Nunito |
| Paper & Ink | #2B2B2B | 米黄 | Cormorant Garamond + Source Serif 4 |
