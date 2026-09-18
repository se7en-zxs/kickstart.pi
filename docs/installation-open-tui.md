# 交互界面：pi-open-tui

[pi-open-tui](https://pi.dev/packages/pi-open-tui) 是 pi 的打磨过的 TUI 样式扩展，把 `pi-haiku`、`pi-claude-code-tui`、`pi-zentui` 的优秀集于一个包：16 帧动画 Pi logo 头部、两行 [Starship](https://starship.rs/)-风格的底部（cwd、git 分支与状态、运行版本、上下文条、模型、token、成本）、带强调色轨的圆角编辑器、工作时间计时 + 轮次遥测（TPS / TTFT / 卡顿），以及交互式 `/open-tui` 设置 UI。

## Install

```bash
pi install npm:pi-open-tui
```

这会把包加进你的全局 pi 设置（`~/.pi/agent/settings.json`）。pi 启动时自动发现。

> 建议在**全局级**安装：头部、底部与编辑器外围是会话级 UI——一次安装覆盖每个项目，无需逐项目配置。

想**先单次试用、不安装**：

```bash
pi -e npm:pi-open-tui
```

## Verify

在一个全新 `pi` 会话里确认三样都可见：

- TUI 顶部有一个**动画头部**，循环 16 帧 Pi logo 配色，外加 "Let's build something great" 标语。
- **两行底部**显示你的 cwd、git 分支与状态、运行版本、上下文条、模型、token 数与成本。
- **圆角编辑器**带着强调色轨和圆角边框框住输入。

## Activate

重启 pi，或在会话里跑 `/reload`。

## Configure

在 pi 会话里运行 `/open-tui` 打开带标签页的设置对话框，四个分区可用 `Tab` / `Shift+Tab` 切换：

- **Features** —— 开关头部、底部、圆角编辑器、遥测等
- **Icons** —— `auto`（检测 Nerd Font）、`nerd`（强制 Nerd Font 字形）、`ascii`（纯后备）
- **Segments** —— 显隐各底部段（cwd、git 分支、git 状态、git commit hash、运行、上下文、token、成本）
- **Telemetry** —— 开关轮次后的通知及其分段（TPS、TTFT、时长、token、卡顿、成本）

用户配置持久化在 `~/.pi/agent/open-tui.json`。缺失或无效的值回退到 open-tui 默认值。

## Uninstall

```bash
pi remove npm:pi-open-tui
```

从 `~/.pi/agent/settings.json` 删除条目。其它包与你的 open-tui 配置（`~/.pi/agent/open-tui.json`）**不受动**。

## Scope

pi-open-tui 只改 TUI 外观——不改模型行为、工具调用或提示词内容。