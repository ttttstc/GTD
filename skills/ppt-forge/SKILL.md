---
name: ppt-forge
description: |
  PPT 制作全链路流水线：内容规划 → 风格定调 → Slide 制作 → 视觉审查 → 导出验证 → 交付。
  Use when: 做 PPT、做演示文稿、做 slide、做海报、PPT review、视觉审查。
  Not for: 纯代码开发（用 worktree/tdd）、纯文档写作（直接写）。
  Output: 高密度 HTML slide + 视觉审查通过 + 导出验证 + PPTX/PDF 可选。
---

# PPT Forge — 演示文稿生产线

## 核心原则

**PPT 制作是一个结构化流水线，每个阶段有明确的输入、输出和验收标准。**

| 阶段 | 主导 | 职责 |
|------|------|------|
| Planning | **Author** | 内容规划、页型选择、证据源整理 |
| Style | **Author** + **Review** | 风格定调、核心页 CSS 基线 |
| Authoring | **Author** | HTML slide 批量制作 |
| Review | **Layout Review** + **Brand Review** | 布局/信息审查 + 品牌/审美审查 |
| Export | **Author** | 导出验证、格式检查 |
| Delivery | **Author** | 预览交付、文件归档 |

## 开局参数（必须声明）

制作前必须先锁定以下参数，作为后续所有阶段的标准依据：

| 参数 | 说明 | 示例 |
|------|------|------|
| **输出格式** | 单文件完整版还是分页 | **HTML 单文件** / **PPTX 单文件** / 分页 HTML |
| 页型（archetype） | 决定密度、字号矩阵和信息组织方式 | 战略总览 / 数据洞察 / 方案对比 / 汇报页 |
| 品牌 | 对标公司的视觉基因 | 华为 / Apple / 阿里 / 通用 |
| 受众 | 谁看这个 PPT | CTO / 投资人 / 技术团队 / 客户 |
| 场景 | PPT 用在哪 | 年会汇报 / 客户提案 / 内部分享 / 产品发布 |
| 主观看模式 | 影响字号/密度/留白标准 | presentation（大屏投影）/ document（PDF 阅读） |

**没有开局参数 = 开工和审查都没有标准。开局前必须先锁这 6 项。**

## 场景路由

| 触发 | 场景 | 主导 | 详细文档 |
|------|------|------|---------|
| 用户说"做个 PPT" | **P: 内容规划** | Author | refs/ppt-slide-authoring.md（规划部分） |
| 大纲确认 | **S: 风格定调** | Author 做 + Review 审 | refs/ppt-style-tile.md |
| 风格确认 | **A: Slide 批量制作** | Author | refs/ppt-slide-authoring.md |
| Slide 做完 | **R: 视觉审查** | Layout Review (D1) + Brand Review (D2) | refs/ppt-visual-review.md |
| 审查通过 | **E: 导出/组装** | Author | refs/ppt-delivery.md |
| 导出验证通过 | **D: 交付** | Author | refs/ppt-delivery.md |
| 需要对比竞品 | **B: Benchmark 对拍** | Author | refs/ppt-visual-review.md |
| 用户不满意 / 连续 2 轮 P1>0 | **Reset: 翻盘重来** | — | 回到 P 阶段重新规划 |

## 场景详解

### P: 内容规划

- 先锁：`archetype / 品牌 / 受众 / 场景 / 主观看模式`
- 至少产出：`本次 PPT 的一句话目标 + 证据源列表 + 页面结构草图`
- 没说清"这页让人看完要得出什么结论" → 不进 A 阶段

### S: 风格定调

- 先做 1-2 张核心页（封面 + 最复杂内容页）
- 提取 CSS 变量（品牌色/字号/间距/圆角）
- Review 确认风格后，Author 按 CSS 变量批量制作

### A: Slide 批量制作

- 按 archetype 选模板
- 密度驱动：每页至少 3 种填充手段
- 完成后自检截图 + 密度数据

### R: 视觉审查

详见 refs/ppt-visual-review.md

- D1 Layout Review：布局/信息审查（P1 级问题）
- D2 Brand Review：审美/品牌审查（P2 级问题）
- 必须有 6 件套输入包才能提审

### E: 导出验证

- 检查：native text / native chart / native table / screenshot fallback / repair dialog
- 任何一项有问题 → 不进 D

### D: 交付

详见 refs/ppt-delivery.md

- 必须用 browser-preview 打开预览
- 交付物：HTML 预览 + 截图 + PPTX/PDF（如需要）
- 等用户确认后才能结束

## 视觉审查 6 件套

每次发起视觉审查，必须附带：

1. **品牌+受众 brief** — "华为风格，受众 CTO，1 页讲清 moat"
2. **页型（archetype）+ 主观看模式** — 防止 reviewer 把页面改型
3. **本页目的** — 一句话说清这页要达成什么
4. **截图/预览 URL** — 渲染结果
5. **HTML/CSS 源码** — 定位布局 bug 用
6. **密度数据** — whitespace%、element count、overflow

> 没有 6 件套 = 观感点评；有 6 件套 = P1/P2 级审查。

## 审查维度速查

### D1: 布局/信息审查（Layout Review）

| 级别 | 维度 | 判定 |
|------|------|------|
| P1 | 布局 bug | 真实 CSS/HTML 错误 |
| P1 | 信息失败 | 没讲清重点 / 层级错 / 受众看不懂 |
| P1 | 密度失衡 | 该密不密 / 该疏不疏 |

### D2: 品牌/审美审查（Brand Review）

| 级别 | 维度 | 判定 |
|------|------|------|
| P2 | 品牌偏移 | 不像目标公司的设计语言 |
| P2 | 视觉一致性 | 字号/卡片/边框/图标语言不统一 |

审美五维：色彩体系 · 字体排印 · 空间网格 · 视觉元素 · 密度平衡

## 密度填充手法

详见 refs/ppt-density-playbook.md

## 交付物清单

根据开局参数的**输出格式**，生成对应单文件：

| 格式 | 说明 | 文件特征 |
|------|------|---------|
| **HTML 单文件** | 完整 PPT，所有 slide 内嵌在一个 HTML 中 | `*.html`，可用浏览器直接打开，支持翻页 |
| **PPTX 单文件** | 完整 PPT，所有 slide 内嵌在一个 PPTX 中 | `*.pptx`，可用 PowerPoint/WPS 直接打开 |
| 分页 HTML | 每个 slide 一个文件 | `01.html`, `02.html`...（仅用于审查阶段） |

**默认输出：HTML 单文件**。用户明确要求 .pptx 时生成 PPTX 版本。

## Common Mistakes

| 错误 | 后果 | 修复 |
|------|------|------|
| 没声明开局参数 | 开工和审查没有标准 | 开工前锁 6 参数（含输出格式） |
| 20 页全做完才审 | 返工成本爆炸 | S 阶段：先做 1-2 页核心页定调 |
| 自己说"没问题"不截图 | 布局 bug 漏检 | 自检必须截图看一遍再交活 |
| 审查只给截图没给 HTML | 只能说"这里怪" | 必须带 6 件套 |
| 生成多个 HTML 而非单文件 | 用户需要逐个打开 | E 阶段必须组装为 reveal.js 单文件 |
| PPTX 字号没换算 | 文字太小不可读 | CSS_px × 0.75 = PPTX_pt |
| 跳过 Export Gate | 导出后不可编辑/乱码 | 独立验证导出质量 |

## 品牌模板

品牌模板是特定公司的视觉规范预设，选择品牌后自动应用对应规范：

| 品牌 | 模板路径 | 特征 |
|------|---------|------|
| 华为 | refs/huawei/template.md | 红/黑/灰、直角体系、高密度 |
| ZaraPPT | refs/zarappt/template.md | 12种预设、滚动驱动、SlidePresentation JS、Fontshare字体 |
| Apple | （待扩展） | 极简、大量留白 |
| 阿里 | （待扩展） | 橙/科技蓝、Dashboard |
| 通用 | — | 可配置，根据 brief 调整 |

**使用**：开局参数选择品牌后 → S 阶段风格定调时使用对应模板的 CSS 变量

### ZaraPPT 特殊说明

选择 ZaraPPT 时，**必须继承 frontend-slides 核心原则**：

| 原则 | 要求 |
|------|------|
| Zero-dependency | 单 HTML 文件，内联 CSS/JS，无外部依赖 |
| 强制视口适配 | 每个 `.slide` 必须 `height: 100vh; overflow: hidden` |
| Fontshare 字体 | 禁止系统字体，必须用在线字体 |
| clamp() 字号 | 所有字号必须用 `clamp(min, preferred, max)` |
| .visible 动画 | 动画通过 IntersectionObserver + `.visible` 类触发 |
| SlidePresentation JS | 必须包含键盘/触摸/进度条导航 |

### ZaraPPT 风格选择流程（S 阶段）

**"Show, Don't Tell" — 风格不是选出来的，是看出来的。**

1. **问用户想要什么感受**（单选，最多 2 个）：
   - Impressed/Confident — 专业、可信赖
   - Excited/Energized — 创新、大胆
   - Calm/Focused — 清晰、专注
   - Inspired/Moved — 情感、有记忆点

2. **根据感受推荐预设**（详见 `refs/zarappt/zarappt-presets.md`）：

   | 感受 | 推荐预设 |
   |------|---------|
   | Impressed/Confident | Bold Signal, Electric Studio, Dark Botanical |
   | Excited/Energized | Creative Voltage, Neon Cyber, Split Pastel |
   | Calm/Focused | Notebook Tabs, Paper & Ink, Swiss Modern |
   | Inspired/Moved | Dark Botanical, Vintage Editorial, Pastel Geometry |

3. **生成 3 个风格预览**（可选）：为用户生成单页 HTML 预览，展示字体、颜色、动画效果

4. **用户选择或混搭**：确定最终风格后进入 A 阶段

详见 `refs/zarappt/html-template.md`

## 参考文档

| 文档 | 内容 |
|------|------|
| refs/ppt-style-tile.md | 风格定调详细流程 |
| refs/ppt-slide-authoring.md | HTML 制作规范 |
| refs/ppt-visual-review.md | 视觉审查 Gate |
| refs/ppt-delivery.md | 交付流程 |
| refs/ppt-density-playbook.md | 密度填充手册 |
| refs/huawei/template.md | 华为品牌模板 |
| refs/huawei/huawei-brand.md | 华为视觉规范 |
| refs/huawei/huawei-archetypes.md | 华为页型模板 |
| refs/huawei/huawei-density-rules.md | 华为密度标准 |
| refs/zarappt/template.md | ZaraPPT 品牌模板 |
| refs/zarappt/zarappt-presets.md | 12 种视觉预设 |
| refs/zarappt/zarappt-viewport.css | 视口适配 CSS |
| refs/zarappt/zarappt-animation.md | 动画系统 |
| refs/zarappt/html-template.md | HTML 架构规范 + SlidePresentation JS |
