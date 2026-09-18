# 多代理（轻量）：pi-subagents-lite

[pi-subagents-lite](https://pi.dev/packages/pi-subagents-lite) 以 schema-first、**最小 token 开销**的设计为 pi 带来子代理能力——在隔离会话里派发专精代理，每个有自己的工具、扩展与模型，可前台也可后台。只有三个工具（`Agent`、`StopAgent`、`AgentStatus`），无臃肿描述；指挥与续跑、自定义 agent 类型、按模型并发上限、带成本追踪的实时 widget、面向卡住代理的看门狗，都由 `/agents` 统一管理。

> 需要 **Node.js >= 18** 与 **pi >= 0.82.0**。

> 想要更接近 Claude Code、能力更完整（含 FleetView、前台/后台子代理）的变体，见 [installation-subagents.md](installation-subagents.md)。

## Install

```bash
pi install npm:pi-subagents-lite
```

这会把扩展加进全局 pi 设置（`~/.pi/agent/settings.json`）。pi 启动时自动发现。

> 建议在**全局级**安装：`Agent` / `StopAgent` / `AgentStatus` 工具是会话级能力——一次安装覆盖每个项目。自定义 agent 定义仍可通过 `.pi/agents/*.md` 按项目限定；项目级模型/并发默认值则可放在 `.pi/subagents-lite.json`。

## Verify

在一个全新 `pi` 会话里确认：

- 三个子代理工具对模型可用：`Agent`（派发）、`StopAgent`（按 ID 停掉运行中或排队中的 agent）、`AgentStatus`（列出所有 agent 的类型、短 ID 与状态）。
- 运行 `/agents` 打开管理菜单。

## Activate

重启 pi，或在意有 `pi` 会话里跑 `/reload`。

## Configure

### 派发（Spawning）

LLM 像调用其它工具一样调用 `Agent`：

- `prompt`（必填）—— 任务文本
- `description` —— widget 的短标签；默认取提示第一行
- `agent` —— agent 类型；默认 `general-purpose`
- `run_in_background` —— 立即返回，完成后通知父会话
- `worktree_path` —— 磁盘上的任意 git 仓库：父仓库的 worktree、其主 checkout、或完全不同的仓库

`model`、`thinking`、`max_turns`、`max_tokens` 从配置与 frontmatter 注入，LLM 从不直接传——设一次就忘。前台代理不锁死会话且绑在父会话的中断上（停父就停它们，部分输出保留）；后台代理完全自治。子代理不能再派生子代理。

### `/agents` 菜单

一个菜单管所有：

- **运行中的代理** —— 看实时对话、中途指挥、续跑已定局的代理、停止、清空
- **Spawn** —— 不经过 LLM,手动派发一个 agent
- **Model settings** —— 全局默认与按类型的模型覆盖
- **Concurrency** —— 按模型的并发槽上限；按模型上限 > 按供应商上限 > `default`。超出的 spawn 排队等待空闲槽
- **Agent defaults** —— thinking、最大轮数、强制后台
- **System prompt** —— 提示词模式、是否含 `AGENTS.md`、技能、扩展
- **Widget** —— 布局与可见性
- **Watchdog** —— 面向卡住代理的工具与空闲超时

### Widget 与对话查看器

运行中与刚结束的代理显示在编辑器上方。`↓`/`↑` 高亮一个代理，`Enter` 打开实时记录（thinking 块、工具调用、压缩摘要、结果），`Esc` 关闭。在查看器里按 `Enter` 或 `/agents` 菜单的 `Steer` 指挥运行中的代理；已定局的（完成、出错、停止、轮数受限）可在查看器里手动续跑。

### 自定义 agent 类型

把一个 `.md` 文件放进 `.pi/agents/`（项目）、`.agents/agents/`（共享）或 `~/.pi/agent/agents/`（全局）。Frontmatter 配置 agent；正文就是它的系统提示词。名字会自动填进 `Agent` 的 `agent` 参数枚举——无需注册。名称冲突时：项目 > 共享 > 用户 > 内置（大小写不敏感解析）。

```markdown
---
name: security-review
description: Review code for security issues
tools: [read, bash, grep]
extensions: false
skills: false
model: zai/glm-5.2
thinking: high
max_turns: 80
---

You are a security review specialist. Analyze code for vulnerabilities,
focusing on injection flaws, auth bypasses, and insecure defaults.
```

只有 `name` 和 `description` 的最小 agent 就能获得一切能力，等同 `general-purpose`。只在需要时才设限制。常用 frontmatter 键：

| 键 | 作用 |
|---|---|
| `tools` / `exclude_tools` | 工具白名单 / 黑名单（`read`、`bash` 等内置；扩展工具名；`ext/*` glob）|
| `extensions` / `exclude_extensions` | 加载哪些扩展（hooks 与 commands）。不管工具可见性 |
| `skills` / `preload_skills` | 技能白名单（仅元数据）/ 把完整 SKILL.md 内容倒入系统提示词 |
| `model` / `thinking` | `"provider/model-id"` 与推理层级；默认继承父级 |
| `max_turns` / `max_tokens` | 软轮数上限（硬中止前的宽限轮数）/ 每次响应的最大输出 token |
| `hidden` | 从枚举中隐藏；仍可按名字调用 |

内置类型：`general-purpose`（完整会话工具）与 `Explore`（只读代码库调研）。它们可被自定义 agent 覆盖，或在 `/agents` 里禁用。

### 配置文件

- **全局** —— `~/.pi/agent/subagents-lite.json`，通过 `/agents` 管理或直接编辑
- **项目覆盖** —— `.pi/subagents-lite.json`：一个覆盖层，只能含模型与并发设置（`agent.default`、按类型模型覆盖、`concurrency`）。生效顺序：会话覆盖 > 项目文件 > 系统文件 > 内置默认

### 系统提示词模式

`systemPromptMode`（默认 `replace`）：

- `replace` —— 最小通用提示 + agent 指令。成本最低、最隔离
- `inherit` —— 父级系统提示 + agent 指令
- `custom` —— `~/.pi/agent/subagents-lite-prompt.md` + agent 指令

当 `includeContextFiles` 为 `true`（默认）时，AGENTS.md 文件作为共享上下文在 agent 指令之前加载，这能提高 KV cache 前缀命中。

### Watchdog 与记录

watchdog 停在挂起的代理并在杀掉时通知主会话。两个独立检查，都默认 45 分钟（`0` 关闭）：`toolTimeoutMinutes`（单个工具调用过久）与 `idleTimeoutMinutes`（长时间无工具事件或流式文本）。可选输出记录——流式写到 `/tmp/pi-agent-outputs/<agentId>.log`（追加式，`tail -f` 友好）——全局或按 agent 通过 `output_transcript` frontmatter 字段开启。

## Uninstall

```bash
pi remove npm:pi-subagents-lite
```

从 `~/.pi/agent/settings.json` 删除条目。自定义代理定义（`.pi/agents/`、`.agents/agents/`、`~/.pi/agent/agents/`）与配置文件（`~/.pi/agent/subagents-lite.json`、`.pi/subagents-lite.json`）**不受动**。

## Scope

pi-subagents-lite 只增加三个工具、一个实时 widget、一个对话查看器和 `/agents` 菜单——不改变主 agent 行为、系统提示词或默认工具列表。模型、thinking、轮次和 token 上限由你的配置注入，LLM 看到的 schema 保持很小。