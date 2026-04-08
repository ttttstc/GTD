# ZaraPPT 视觉预设

> 12 种精心设计的视觉风格，适用于不同场景的前端技术分享。

## 预设概览

| 编号 | 预设名 | 主色 | 辅色 | 背景 | 风格 |
|------|--------|------|------|------|------|
| 1 | Bold Signal | #FF4D4D | #FFC857 | #0D0D0D | 粗体、高对比 |
| 2 | Electric Studio | #7B2FFF | #00D4FF | #1A1A2E | 电光、渐变 |
| 3 | Creative Voltage | #FF6B35 | #F7C548 | #1A1A1A | 活力、饱和 |
| 4 | Dark Botanical | #2D5A3D | #8FB996 | #1C231F | 暗黑、自然 |
| 5 | Notebook Tabs | #E8857B | #F5D547 | #FFF9E8 | 温暖、手绘感 |
| 6 | Pastel Geometry | #A8D8EA | #FCBAD3 | #FFFEF9 | 粉彩、柔和 |
| 7 | Split Pastel | #B5EAD7 | #FFD3B6 | #FFF9F0 | 分屏、对比 |
| 8 | Vintage Editorial | #8B4513 | #D4A574 | #F5E6D3 | 复古、杂志 |
| 9 | Neon Cyber | #00FFF0 | #FF00FF | #0A0A0A | 霓虹、科技 |
| 10 | Terminal Green | #00FF00 | #008800 | #0D0D0D | 终端、代码 |
| 11 | Swiss Modern | #E63946 | #1D3557 | #FFFFFF | 极简、专业 |
| 12 | Paper & Ink | #2B2B2B | #6B6B6B | #F5F5DC | 纸墨、文档 |

---

## 预设 1: Bold Signal

**关键词**: 粗体、信号色、高对比度、科技感

### 色彩体系

```css
--preset-primary: #FF4D4D;      /* 信号红 */
--preset-secondary: #FFC857;   /* 琥珀黄 */
--preset-bg: #0D0D0D;          /* 深黑 */
--preset-text: #FFFFFF;
--preset-accent: #00FFD1;      /* 青色点缀 */
```

### 字体排印

- 标题: **粗体**, 大字号, letter-spacing: 0.05em
- 正文: 中等粗细, 高行高 (1.6)
- 代码: monospace, 背景色块

### 空间网格

- 大量留白
- 居中或左对齐布局
- 卡片圆角: 0px (锐利)

### 视觉元素

- 粗线条分隔
- 色块强调
- 简洁图标

---

## 预设 2: Electric Studio

**关键词**: 电光、渐变、赛博朋克

### 色彩体系

```css
--preset-primary: #7B2FFF;      /* 电紫 */
--preset-secondary: #00D4FF;    /* 荧光蓝 */
--preset-bg: #1A1A2E;           /* 深蓝黑 */
--preset-text: #FFFFFF;
--preset-accent: #FF00FF;       /* 品红 */
```

### 字体排印

- 标题: 粗体, 渐变色或发光效果
- 正文: 清晰可读, 适当字重
- 代码: 高对比度背景

### 空间网格

- 中等密度
- 左右分区布局
- 卡片圆角: 4px

### 视觉元素

- 渐变背景
- 发光边框
- 霓虹线条

---

## 预设 3: Creative Voltage

**关键词**: 活力、高饱和、创意感

### 色彩体系

```css
--preset-primary: #FF6B35;      /* 活力橙 */
--preset-secondary: #F7C548;    /* 明黄 */
--preset-bg: #1A1A1A;           /* 深灰 */
--preset-text: #FFFFFF;
--preset-accent: #FF3366;       /* 玫红 */
```

### 字体排印

- 标题: 超粗体, 斜体装饰
- 正文: 活泼字重
- 代码: 暖色调背景

### 空间网格

- 动态不对称布局
- 卡片圆角: 8px
- 彩色边框

### 视觉元素

- 几何形状
- 彩色条纹
- 创意图标

---

## 预设 4: Dark Botanical

**关键词**: 暗黑、自然、有机纹理

### 色彩体系

```css
--preset-primary: #2D5A3D;      /* 森林绿 */
--preset-secondary: #8FB996;     /* 苔藓绿 */
--preset-bg: #1C231F;            /* 深墨绿 */
--preset-text: #E8E8E8;
--preset-accent: #C4A35A;        /* 金色 */
```

### 字体排印

- 标题:衬线体, 优雅
- 正文: 无衬线, 舒适行高
- 代码: 深色背景

### 空间网格

- 大量留白
- 居中布局
- 卡片圆角: 12px

### 视觉元素

- 植物纹理背景
- 金色点缀线
- 自然图标

---

## 预设 5: Notebook Tabs

**关键词**: 笔记本、便签、手绘感

### 色彩体系

```css
--preset-primary: #E8857B;      /* 珊瑚红 */
--preset-secondary: #F5D547;    /* 便签黄 */
--preset-bg: #FFF9E8;           /* 米白 */
--preset-text: #333333;
--preset-accent: #7EB5A6;       /* 薄荷绿 */
```

### 字体排印

- 标题: 手写风格或圆润字体
- 正文: 清晰易读
- 代码: 浅色背景 + 边框

### 空间网格

- 笔记本线纹背景
- 便签式卡片
- 卡片圆角: 4px

### 视觉元素

- 标签页装饰
- 便签效果
- 手绘图标

---

## 预设 6: Pastel Geometry

**关键词**: 粉彩、柔和、几何

### 色彩体系

```css
--preset-primary: #A8D8EA;      /* 粉蓝 */
--preset-secondary: #FCBAD3;    /* 粉红 */
--preset-bg: #FFFEF9;           /* 象牙白 */
--preset-text: #4A4A4A;
--preset-accent: #AA96DA;       /* 淡紫 */
```

### 字体排印

- 标题: 圆润粗体
- 正文: 轻盈字重
- 代码: 柔和背景

### 空间网格

- 几何卡片布局
- 柔和阴影
- 卡片圆角: 16px

### 视觉元素

- 圆形/方形几何
- 柔和渐变
- 简约图标

---

## 预设 7: Split Pastel

**关键词**: 分屏、粉彩、对比

### 色彩体系

```css
--preset-primary: #B5EAD7;       /* 薄荷绿 */
--preset-secondary: #FFD3B6;     /* 蜜桃色 */
--preset-bg: #FFF9F0;           /* 暖白 */
--preset-text: #4A4A4A;
--preset-accent: #FF9AA2;        /* 樱粉 */
```

### 字体排印

- 标题: 柔和粗体
- 正文: 正常字重
- 代码: 分屏背景

### 空间网格

- 左右分屏
- 中心分割线
- 卡片圆角: 8px

### 视觉元素

- 分割背景
- 色块对比
- 对称布局

---

## 预设 8: Vintage Editorial

**关键词**: 复古、杂志、编辑感

### 色彩体系

```css
--preset-primary: #8B4513;       /* 棕褐 */
--preset-secondary: #D4A574;     /* 驼色 */
--preset-bg: #F5E6D3;            /* 羊皮纸 */
--preset-text: #2B2B2B;
--preset-accent: #C41E3A;        /* 复古红 */
```

### 字体排印

- 标题: 衬线体, 大写装饰
- 正文: 报纸风格
- 代码: 打字机风格

### 空间网格

- 经典杂志排版
- 栏式布局
- 卡片圆角: 0px

### 视觉元素

- 装饰线
- 老式边框
- 复古图标

---

## 预设 9: Neon Cyber

**关键词**: 霓虹、赛博、未来感

### 色彩体系

```css
--preset-primary: #00FFF0;       /* 霓虹青 */
--preset-secondary: #FF00FF;      /* 霓虹紫 */
--preset-bg: #0A0A0A;            /* 纯黑 */
--preset-text: #FFFFFF;
--preset-accent: #FFFF00;        /* 霓虹黄 */
```

### 字体排印

- 标题: 超粗体, 发光效果
- 正文: 清晰高对比
- 代码: 终端风格

### 空间网格

- 科技感布局
- 扫描线背景
- 卡片圆角: 0px

### 视觉元素

- 霓虹边框
- 扫描线效果
- 数字装饰

---

## 预设 10: Terminal Green

**关键词**: 终端、绿屏、代码友好

### 色彩体系

```css
--preset-primary: #00FF00;       /* 终端绿 */
--preset-secondary: #008800;     /* 深绿 */
--preset-bg: #0D0D0D;            /* 纯黑 */
--preset-text: #00FF00;
--preset-accent: #00CC00;        /* 中绿 */
```

### 字体排印

- 标题: monospace, 粗体
- 正文: monospace
- 代码: 原生终端风格

### 空间网格

- 等宽字体主导
- 终端输出布局
- 卡片圆角: 0px

### 视觉元素

- 光标闪烁
- 终端边框
- 命令行图标

---

## 预设 11: Swiss Modern

**关键词**: 极简、瑞士、国际主义

### 色彩体系

```css
--preset-primary: #E63946;       /* 瑞士红 */
--preset-secondary: #1D3557;     /* 深蓝 */
--preset-bg: #FFFFFF;            /* 纯白 */
--preset-text: #1A1A1A;
--preset-accent: #457B9D;        /* 中蓝 */
```

### 字体排印

- 标题: 无衬线, 粗体, 大间距
- 正文: 无衬线, 清晰
- 代码: 简洁背景

### 空间网格

- 严格的网格系统
- 大量留白
- 卡片圆角: 0px

### 视觉元素

- 几何线条
- 极简图标
- 数据可视化

---

## 预设 12: Paper & Ink

**关键词**: 纸墨、文档、学术

### 色彩体系

```css
--preset-primary: #2B2B2B;       /* 墨黑 */
--preset-secondary: #6B6B6B;      /* 灰色 */
--preset-bg: #F5F5DC;             /* 米黄 */
--preset-text: #2B2B2B;
--preset-accent: #8B4513;        /* 棕褐 */
```

### 字体排印

- 标题: 衬线体, 学术感
- 正文: 无衬线, 易读
- 代码: 浅色背景

### 空间网格

- 文档式布局
- 舒适的行高
- 卡片圆角: 2px

### 视觉元素

- 纸张纹理
- 书签线
- 学术图标

---

## 预设选择指南

| 场景 | 推荐预设 |
|------|---------|
| 前端大会演讲 | Bold Signal, Swiss Modern |
| 代码演示 | Terminal Green, Neon Cyber |
| 技术培训 | Paper & Ink, Notebook Tabs |
| 产品介绍 | Electric Studio, Creative Voltage |
| 设计提案 | Pastel Geometry, Split Pastel |
| 历史回顾 | Vintage Editorial, Dark Botanical |

---

## 字体配对速查表

| 预设 | Display Font | Body Font | 来源 |
|------|-------------|-----------|------|
| Bold Signal | Archivo Black | Space Grotesk | Google |
| Electric Studio | Manrope | Manrope | Google |
| Creative Voltage | Syne | Space Mono | Google |
| Dark Botanical | Cormorant | IBM Plex Sans | Google |
| Notebook Tabs | Bodoni Moda | DM Sans | Google |
| Pastel Geometry | Plus Jakarta Sans | Plus Jakarta Sans | Google |
| Split Pastel | Outfit | Outfit | Google |
| Vintage Editorial | Fraunces | Work Sans | Google |
| Neon Cyber | Clash Display | Satoshi | Fontshare |
| Terminal Green | JetBrains Mono | JetBrains Mono | JetBrains |
| Swiss Modern | Archivo | Nunito | Google |
| Paper & Ink | Cormorant Garamond | Source Serif 4 | Google |

---

## 感受与预设映射

| 感受 | 推荐预设 |
|------|---------|
| Impressed/Confident（专业、可信赖） | Bold Signal, Electric Studio, Dark Botanical |
| Excited/Energized（创新、大胆） | Creative Voltage, Neon Cyber, Split Pastel |
| Calm/Focused（清晰、专注） | Notebook Tabs, Paper & Ink, Swiss Modern |
| Inspired/Moved（情感、有记忆点） | Dark Botanical, Vintage Editorial, Pastel Geometry |

---

## 禁止使用（通用 AI 模式）

**字体**: Inter, Roboto, Arial, 系统字体作为标题

**颜色**: `#6366f1`（通用靛蓝），白色背景上的紫色渐变

**布局**: 全部居中，通用 hero section，相同的卡片网格

**装饰**: 写实插图，过度的玻璃态，无目的的阴影
