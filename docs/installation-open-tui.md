# 交互界面：pi-open-tui

pi-open-tui 为 pi 提供**终端 TUI 交互界面**，在终端里呈现更可视化的会话体验（主题、图标、状态栏，支持多语言 UI 等）。

> 来源：npm 包 `pi-open-tui`。

---

## Install

```bash
pi install npm:pi-open-tui
```

## Verify

- `pi list` 应出现 `pi-open-tui`。
- 确认 `~/.pi/agent` 下生成 `open-tui.json` 配置文件；在支持 TUI 的终端运行 `pi`，界面应启用 TUI。

## Activate / 配置

通过 `~/.pi/agent/open-tui.json` 配置界面。常见字段：

```jsonc
{
  "enabled": true,
  "uiLang": "zh",
  "useNerdIcons": true,
  "showBar": {
    "cwd": true,
    "session": true,
    "gitBranch": true,
    "gitStatus": true,
    "runtime": true,
    "context": true,
    "tokens": true,
    "cost": true
  },
  "telemetry": true
}
```

> 字段以该扩展实际配置为准。`uiLang` 可设为 `zh` 或 `en`；状态栏可开关各显示项。

## 卸载

```bash
pi remove npm:pi-open-tui
```

删除 `~/.pi/agent/open-tui.json`（可选），重启 pi 后恢复默认终界面。