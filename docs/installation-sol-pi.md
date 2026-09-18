# 长上下文：SoL-Pi

SoL-Pi（`NVlabs/SoL-Pi`）为 pi 提供**长上下文优化**能力，通过自动上下文压缩、行动/观察打包、证据消减、在线上下文压缩等机制，帮助 pi 在超长会话中保持稳定，提升 token 利用效率。

> 来源：`git:github.com/NVlabs/SoL-Pi`。

---

## Install

```bash
pi install git:github.com/NVlabs/SoL-Pi
```

## Verify

- `pi list` 应出现 `SoL-Pi`。
- 确认配置目录下生成 `~/.pi/agent/sol-pi.json`（或如 `sol-pi.json` 的配置文件）。

## Activate / 配置

SoL-Pi 通过 `sol-pi.json` 配置文件启用各项长上下文特性。典型字段：

```jsonc
{
  "version": 1,
  "actionFusion": true,
  "observationPack": true,
  "evidenceReducingReducer": true,
  "onlineContextCompact": true,
  "contextWindowSize": 336000000
}
```

> 字段含义与默认值以 SoL-Pi 官方仓库说明为准。**启用 `onlineContextCompact` 等自动压缩功能前，建议先用小型任务验证效果**，再应用到正式任务。

> 提示：SoL-Pi 与你的模型供应商的 `contextWindow` 配置配合生效。若未配置长上下文窗口，压缩可能在较短上下文就触发。

## Verify

- 新开会话，加载一个较长上下文任务，观察日志/配置是否显示 SoL-Pi 压缩/打包动作被触发。
- 确认 `sol-pi.json` 的开关项都被解析（无报错）。

## 卸载

```bash
pi remove git:github.com/NVlabs/SoL-Pi
```

删除配置目录中的 `sol-pi.json`（可选）后重启 pi。