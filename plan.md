# GTD Master Pipeline — 总体方案

> 基于 [vision.md](./vision.md) 的愿景与约束，本文档定义架构设计、核心产物、各层详细方案及 Issue 拆分。

---

## 1. 架构概览

```
用户目标（一句模糊的话）
        │
        ▼
┌──────────────────────────────────────────────┐
│  L1 — Mission Clarify (想清楚)               │
│                                              │
│  ┌─────────────┐   ┌──────────────────────┐  │
│  │ 结构化追问   │──▶│ 方法论 Lens 审视     │  │
│  │ (强制闭环)   │   │ (可选, 可插拔)       │  │
│  └─────────────┘   └──────────────────────┘  │
│                        │                     │
│                        ▼                     │
│         产出: mission-brief.md               │
└──────────────────┬───────────────────────────┘
                   │
                   ▼
┌──────────────────────────────────────────────┐
│  L2 — Pipeline Synthesis (拆清楚)            │
│                                              │
│  ┌──────────────┐  ┌───────────────────────┐ │
│  │ 阶段规划      │  │ 验收门设计            │ │
│  └──────┬───────┘  └──────────┬────────────┘ │
│         │                     │              │
│         ▼                     ▼              │
│  ┌──────────────┐  ┌───────────────────────┐ │
│  │ 子工作流匹配  │  │ 防漂移检查            │ │
│  └──────────────┘  └───────────────────────┘ │
│                        │                     │
│                        ▼                     │
│         产出: pipeline.md                    │
└──────────────────┬───────────────────────────┘
                   │
                   ▼
┌──────────────────────────────────────────────┐
│  L3 — Gated Execution (做到位)               │
│                                              │
│  Stage 1 ──✓──▶ Stage 2 ──✓──▶ Stage N     │
│  (子工作流)  质量门 (子工作流)  质量门 (manual)│
│                                              │
│  控制信号: PASS → 下一阶段                    │
│           FAIL → 重试 / 调整标准              │
│           PIVOT → 回到 L1 或 L2 重新评估      │
└──────────────────────────────────────────────┘
```

## 2. 核心产物定义

### 2.1 目标定义文档 (mission-brief.md)

L1 的唯一产出，后续一切的锚点。

```markdown
# Mission Brief: {目标名称}
created: {日期}
status: draft | confirmed

## 终态描述
做完之后世界有什么不同？（一段话，具体可感知）

## 成功标准
- [ ] 标准 1（可检验的）
- [ ] 标准 2（可检验的）

## 边界约束
- 不做：...
- 不做：...
- 最晚截止：...

## 风险识别
- 风险 1：...
- 风险 2：...

## 复杂度判定
等级：simple | moderate | complex
依据：...

## 策略决议（复杂度为 complex 时，经方法论审视后填写）
- 关键杠杆点：...
- 核心风险：...
- 采纳的方法论洞察：...
```

### 2.2 Pipeline Definition (pipeline.md)

L2 的唯一产出，执行阶段的路线图。

```markdown
# Pipeline: {目标名称}
mission_brief: ./mission-brief.md
created: {日期}
status: planning | executing | completed | pivoted

## Stage 1: {阶段名称}
- **目标**: 一句话
- **交付物**: 具体产出是什么
- **验收门**:
  - 类型: metric | human_confirm
  - 标准: "测试覆盖率 > 80%" 或 "架构方案通过评审"
  - 检查方式: auto_check | ask_user
- **子工作流**: {已有 skill 名} | (inline-spec) | manual
- **依赖**: 无 | stage-N
- **状态**: pending | in_progress | passed | failed | skipped

## Stage 2: ...
```

## 3. L1 想清楚 — 详细设计

### 3.1 结构化追问（强制，不可跳过）

无论目标多简单，必须回答以下问题才能产出 mission-brief：

| # | 问题 | 目的 |
|---|------|------|
| Q1 | 做完之后，谁的什么问题被解决了？ | 锁定终态 |
| Q2 | 你（或 stakeholder）怎么知道这件事做完了？ | 逼出验收标准 |
| Q3 | 什么明确不做？ | 画边界，防漂移 |
| Q4 | 最晚什么时候要看到结果？ | 约束资源投入 |
| Q5 | 做这件事最大的风险是什么？ | 识别阻塞点 |

实现方式：Skill 中用 AskUserQuestion 逐一追问，用户回答后结构化写入 mission-brief.md。

### 3.2 复杂度分级

避免简单任务被过度流程化：

- **simple**（写一篇博客、修一个 bug）：跑完 Q1-Q5 直接进 L3，不生成多阶段 pipeline
- **moderate**（做一个功能、写一份报告）：跑 Q1-Q5 + 生成 2-4 阶段 pipeline
- **complex**（搭一个平台、做一场 campaign）：跑 Q1-Q5 + 方法论审视 + 生成 5-7 阶段 pipeline

判定由 Skill 根据用户回答推断，并交用户确认。

### 3.3 方法论 Lens 审视（complex 时触发）

Lens 不是角色扮演对话，而是**结构化的思维工具调用**——每个 Lens 回答固定问题：

| Lens | 核心问题 | 来源 |
|------|---------|------|
| 第一性原理 | 这件事的本质是什么？剥掉所有类比后剩下什么？ | 费曼 / Musk |
| 聚焦即说不 | 有哪些"好主意"其实应该砍掉？ | 乔布斯 |
| 逆向思维 | 反过来想——怎样做一定会失败？ | 芒格 |

Lens 接口规范：
- **输入**：mission-brief 的终态描述 + 成功标准 + 边界约束
- **输出**：该视角的结构化洞察（固定字段：本质判断、建议砍掉的、关键杠杆、风险预警）
- **格式**：Markdown section，直接追加到 mission-brief 的策略决议段

Lens 可插拔：内置 3 个通用 Lens，同时兼容任何符合接口规范的外部方法论 Skill（如 steve-jobs-skill、naval-skill 等）作为 Lens 加载。

## 4. L2 拆清楚 — 详细设计

### 4.1 阶段生成规则

- 每个阶段有且仅有一个明确目标（一句话能说清）
- 阶段总数约束：3-7 个，超出需审视
- 阶段间依赖关系显式声明，允许并行
- 每个阶段必须关联至少一个验收门

### 4.2 验收门设计

两种类型，每个阶段至少一个：

**指标型 (metric)**
- 有明确的数值或布尔判定
- 示例："API 文档覆盖率 100%"、"构建无 error"、"用户旅程覆盖 3 条以上"
- 检查方式：子工作流执行完后 Agent 自行验证，或读取产出文件数据

**人工确认型 (human_confirm)**
- 需要人做主观判断
- 示例："架构方案符合团队技术栈方向"、"视觉设计符合品牌调性"
- 检查方式：Agent 暂停，呈现交付物摘要 + "10 分长什么样"的参照描述，请人确认 pass/fail
- 借鉴 gstack 的 0-10 评分机制

### 4.3 防漂移检查

Pipeline 生成后自动跑一轮自检：

1. 每个阶段是否直接服务于 mission-brief 中的终态描述？
2. 是否有阶段的产出不被任何下游阶段或最终验收所需？（孤立节点）
3. 总工作量是否与复杂度判定匹配？

### 4.4 子工作流匹配

对每个阶段做匹配：

| 情况 | 处理 |
|------|------|
| 已有 Skill/工作流 | 直接绑定（如软件开发、写作、调研等已有 Skill） |
| 无现成能力 | 生成 inline 执行指导（临时 mini-spec），或标记 manual |
| 标记为待建 | 进入能力建设 backlog，长期沉淀为正式 Skill |

## 5. L3 做到位 — 接口契约

L3 的具体能力不在本框架范围内，但需要定义接口：

### 子工作流输入

```yaml
mission_brief: ./mission-brief.md          # 目标定义文档路径
stage_definition: (从 pipeline.md 提取)     # 当前阶段完整定义
upstream_artifacts: [...]                   # 上游阶段交付物路径
constraints: (从 mission-brief 继承)        # 边界约束
```

### 子工作流输出

```yaml
deliverables: [...]                         # 交付物文件路径
gate_results:
  - name: "测试覆盖率"
    type: metric
    target: "> 80%"
    actual: "85%"
    passed: true
  - name: "架构评审"
    type: human_confirm
    status: pending_review
```

### 执行控制

- **PASS** → 更新 pipeline.md 状态为 passed，进入下一阶段
- **FAIL** → 更新为 failed，提示用户：重试 / 调整标准 / 回退
- **PIVOT** → 回到 L1 或 L2 重新评估（重大方向变更时）

## 6. 与已有项目的关系

### 借鉴的设计模式

| 来源 | 借鉴内容 |
|------|---------|
| gstack | design doc 作为 Skill 间状态传递载体、0-10 评分验收机制、AskUserQuestion 检查点 |
| spec_driven_develop | master progress file 跨会话锚点设计 |
| 方法论 Skill 生态 | steve-jobs-skill、naval-skill 等作为 L1 可插拔 Lens |

### 子工作流对接原则

GTD 不绑定任何具体子工作流。任何符合接口契约（见第 5 节）的 Skill 或工作流均可被阶段绑定，包括但不限于：软件开发工作流、文档写作工作流、深度调研工作流、sprint 管理流程等。

## 7. 业界对比

| 项目 | 做了什么 | 没做什么 | GTD 的差异 |
|------|---------|---------|-----------|
| **gstack** | sprint 全流程，角色切换，design doc 串联 | 局限软件交付域，无通用任务拆解 | 任务域无关的元编排 |
| **spec_driven_develop** | SKILL.md 驱动任务分解+进度追踪 | 无方法论加持，无验收门 | 方法论 Lens + 结构化验收门 |
| **女娲 nuwa-skill** | 提取人物认知操作系统为可运行 Skill | 只产出 perspective skill，不做编排 | 方法论 Skill 作为可插拔思维工具 |
| **Swarms HeavySwarm** | 多 Agent 并行分析 | 依赖 runtime | 纯文件驱动 |
| **GitHub Plan Command** | AI 驱动 issue 拆解 | 绑定 GitHub，无验收闭环 | 平台无关，验收门内置 |

## 8. 文件结构

```
gtd-master-pipeline/
├── SKILL.md                          # 主入口（路由 + 流程控制）
├── README.md
├── vision.md                         # 愿景与约束
├── plan.md                           # 本文档
│
├── skills/
│   ├── mission-clarify/
│   │   ├── SKILL.md                  # L1 想清楚
│   │   └── references/
│   │       ├── forcing-questions.md  # 结构化追问模板
│   │       └── complexity-rules.md   # 复杂度判定规则
│   │
│   ├── pipeline-synthesis/
│   │   ├── SKILL.md                  # L2 拆清楚
│   │   └── references/
│   │       ├── stage-rules.md        # 阶段生成规则
│   │       ├── gate-design.md        # 验收门设计指南
│   │       └── drift-check.md        # 防漂移检查规则
│   │
│   └── gated-execution/
│       ├── SKILL.md                  # L3 执行控制 & 质量门
│       └── references/
│           └── interface-contract.md # 子工作流接口契约
│
├── templates/
│   ├── mission-brief.md              # 目标定义文档模板
│   └── pipeline.md                   # Pipeline Definition 模板
│
├── lens/                             # 方法论 Lens（可插拔）
│   ├── README.md                     # Lens 接口规范
│   ├── first-principles.md           # 第一性原理
│   ├── focus-means-no.md             # 聚焦即说不
│   └── inversion.md                  # 逆向思维
│
└── docs/
    ├── getting-started.md
    ├── how-it-works.md
    └── faq.md
```

## 9. Issue 拆分

### Milestone 1: 核心闭环 MVP

> 目标：跑通"一个真实目标 → 想清楚 → 拆清楚 → 人工执行 → 验收"的完整流程。

| # | 标题 | 层级 | 描述 | 依赖 |
|---|------|------|------|------|
| **1** | 设计 mission-brief 文档模板 | L1 | 定义目标定义文档的标准结构，确保可被下游 L2 解析 | — |
| **2** | 设计 pipeline.md 文档模板 | L2 | 定义 Pipeline Definition 的标准结构，含两种验收门类型 | — |
| **3** | 实现 mission-clarify Skill | L1 | 结构化追问（Q1-Q5），复杂度判定，产出 mission-brief.md | #1 |
| **4** | 实现 pipeline-synthesis Skill | L2 | 读取 mission-brief，生成 pipeline.md，含阶段规划+验收门+防漂移检查 | #2, #3 |
| **5** | 实现 gated-execution Skill | L3 | pass/fail/pivot 逻辑，AskUserQuestion 人工确认流 | #4 |
| **6** | 主 SKILL.md 路由与流程控制 | 框架 | 根据当前文件状态自动路由到正确阶段 | #3, #4, #5 |
| **7** | 端到端验证 | 验证 | 选一个真实任务跑完全流程，记录问题和改进点 | #6 |

### Milestone 2: 方法论增强

| # | 标题 | 层级 | 描述 | 依赖 |
|---|------|------|------|------|
| **8** | 设计 Lens 接口规范 | L1 | 定义 Lens 的标准输入输出格式 | M1 |
| **9** | 实现 3 个内置 Lens | L1 | 第一性原理、聚焦即说不、逆向思维 | #8 |
| **10** | mission-clarify 集成 Lens 审视 | L1 | complex 时自动加载 Lens，输出写入策略决议段 | #8, #9 |
| **11** | 兼容外部方法论 Skill 作为 Lens | L1 | 兼容任何符合接口规范的外部方法论 Skill（如 steve-jobs-skill 等） | #8 |

### Milestone 3: 子工作流对接

| # | 标题 | 层级 | 描述 | 依赖 |
|---|------|------|------|------|
| **12** | 定义子工作流接口契约 | L3 | 标准化输入/输出/控制信号格式 | M1 |
| **13** | 对接首个子工作流示范 | L3 | 选一个已有 Skill 做对接示范，验证接口契约可行性 | #12 |
| **14** | 对接第二个子工作流 | L3 | 验证不同类型阶段的子工作流绑定 | #12 |
| **15** | 临时执行指导生成 | L3 | 无现成子工作流时生成 inline mini-spec | #12 |

### Milestone 4: 体验优化

| # | 标题 | 层级 | 描述 | 依赖 |
|---|------|------|------|------|
| **16** | 跨会话状态恢复 | 框架 | 基于 pipeline.md 状态字段实现断点续跑 | M1 |
| **17** | Pipeline 模板沉淀与复用 | L2 | 成功的 pipeline 可另存为模板复用 | M1 |
| **18** | 能力建设 Backlog 管理 | L3 | "待建"子工作流自动汇总为 backlog 文件 | M1 |
| **19** | 验收门指标自动采集 | L2/L3 | 对接常见指标源，减少人工确认 | #5 |

## 10. 推进建议

1. **先做模板（#1, #2）**，手工填一个真实目标验证结构是否顺手
2. **再做 L1 Skill（#3）**，这是整个框架的入口和最高频使用点
3. **然后 L2（#4）+ 路由（#6）**，此时已经能跑通 MVP 闭环
4. **L3（#5）和方法论（M2）并行推进**，根据实际使用反馈调整优先级

---

*本文档随实现推进持续更新。*
