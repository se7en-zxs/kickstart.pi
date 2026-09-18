# 多代理：pi-subagents

[@tintinweb/pi-subagents](https://pi.dev/packages/@tintinweb/pi-subagents) 给 pi 带来 Claude Code 风格的**自主子代理**——在隔离会话里派发专精代理，每个子代理有自己的工具、系统提示词、模型与推理层级。可前台或后台运行、中途指挥、调度，还能通过 `.pi/agents/*.md`（项目）或全局配置自定义自己的 agent 类型。

> 想要更轻量、token 开销更小的变体（schema-first 的三工具模型），见 [installation-subagents-lite.md](installation-subagents-lite.md)。

## Install

```bash
pi install npm:@tintinweb/pi-subagents
```

这会把扩展加进你的全局 pi 设置（`~/.pi/agent/settings.json`）。pi 启动时自动发现。

> 建议在**全局级**安装：子代理工具（`Agent`、`get_subagent_result`、`steer_subagent`）是会话级能力——一次安装覆盖每个项目。自定义 agent 定义仍可通过 `.pi/agents/*.md` 按项目限定作用域。

## Verify

在一个全新 `pi` 会话里确认：

- **`Agent` 工具可用**——当主 agent 决定委派工作时，它会在模型的工具列表里出现。
- 运行 **`/agents`** 打开 FleetView——一个可导航的列表，展示当前主会话和任何运行中的子代理。

## Activate

重启 pi，或在意有 pi 会话里跑 `/reload`。

## Configure

### `/agents` 斜杠命令

打开 FleetView 检查、导航并指挥运行中的子代理：

- `↓` / `←`（在空提示符处）—— 进入 FleetView
- `↑` / `↓` —— 在 agent 间移动选现
- `Enter` —— 打开所选代理的实时、自动更新的对话
- `Esc` —— 返回主会话
- 在运行中代理上按 `Enter` —— 打开内联编辑器指挥它；`Enter` 发送，`Esc` 或空提交取消
- `x`（再按 `x` 确认）—— 停止某个运行中的代理

结束后代理会在 FleetView 短暂停留再移出；对话查看器会一直开着到完成，方便你读最终输出。

### Widget 可见性

`/agents → Settings → Widget`：

- `all` —— 显示每个 agent（前台 + 后台）
- `background`（默认）—— 隐藏前台运行（它们已作为 `Agent` 工具结果内联呈现）
- `off` —— 完全关闭常驻 widget

### 自定义 agent 类型

在 `.pi/agents/*.md`（项目）或 `~/.pi/agent/agents/*.md`（全局）定义，用 YAML frontmatter：

```markdown
---
name: reviewer
description: Reviews code for correctness and style
model: sonnet
thinking: medium
---

You are a senior engineer reviewing code for correctness, style, and edge cases.
```

可用 frontmatter 键包括 `name`、`description`、`model`（覆盖默认）、`thinking`（推理层级）、`tools`（把 agent 限制到工具子集）。自定义类型会被自动发现，并在主 agent 派发子代理时与内置类型一起提供给主 agent 选择。

## Uninstall

```bash
pi remove npm:@tintinweb/pi-subagents
```

从 `~/.pi/agent/settings.json` 删除条目。`.pi/agents/` 与 `~/.pi/agent/agents/` 里的自定义 agent 定义**不受动**。

## Scope

pi-subagents 只增加子代理工具与 FleetView UI——不改变主 agent 的行为、系统提示词或默认工具列表。