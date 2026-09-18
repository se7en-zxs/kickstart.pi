# 外观：主题 / 美化

pi 的界面主题与美化通过 `~/.pi/agent/settings.json` 中的 `theme` 字段以及相关 UI 扩展调节，主要影响 TUI 观感与终端体验。

> 与视觉相关的界面组件还取决于你是否安装了 pi-open-tui（见 [installation-open-tui.md](./installation-open-tui.md)）。

## 主题

在 `~/.pi/agent/settings.json` 设置 `theme` 字段：

```jsonc
{
  "theme": "light"   // 或 "dark" 等
}
```

- 修改后重启 pi 生效。
- 若想使用更多主题主题，可安装主题扩展或参考 pi 生态的主题包（见 [installation.md](./installation.md) 索引中的「主题 / 美化」类目）。

## 自定义主题

pi 支持自定义主题：将主题 JSON 放入 `~/.pi/agent/themes/` 目录，文件 `name` 字段即为主题名，再在 `settings.json` 中引用。

本仓库自带一份自定义主题：[`themes/hbuilderx-push-light.json`](../themes/hbuilderx-push-light.json)（HBuilderX Push 浅色风格）。

安装：

```bash
mkdir -p ~/.pi/agent/themes
cp themes/hbuilderx-push-light.json ~/.pi/agent/themes/
```

启用：在 `~/.pi/agent/settings.json` 中设置：

```jsonc
{
  "theme": "hbuilderx-push-light"
}
```

修改后重启 pi 生效。

## 美化（结合 TUI）

- 搭配 pi-open-tui 时，可在 `open-tui.json` 中开启 `useNerdIcons`、状态栏等美化项（见对应文档）。
- 部分界面圆角 / 字体视觉度可通过主题扩展调节，按需安装。

## Verify

- 运行 `pi`，观察主题是否符合预期。
- 若安装了扩展型主题包，确认其在 `pi list` 中出现。

## 卸载

- 主题：改回 `theme` 默认值即可。
- 主题扩展包：`pi remove npm:<主题包名>`。