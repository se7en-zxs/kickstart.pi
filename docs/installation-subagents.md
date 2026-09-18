# 多代理：pi-subagents

pi-subagents 让 pi 可以**并行派发多个子代理**处理独立任务，适用于需要分头搜索、并行调研、批量分析等场景，可显著提升复杂任务的处理速度。

> 来源：`@tintinweb/pi-subagents`（npm）。另有轻量变体 `pi-subagents-lite`，按需选用。

---

## Install

```bash
pi install npm:@tintinweb/pi-subagents
```

若需要更轻量的版本：

```bash
pi install npm:pi-subagents-lite
```

安装后，扩展会写入 `~/.pi/agent/settings.json` 的 `packages` 数组。可用 `pi list` 确认。

## Verify

- 运行 `pi list`，确认 `@tintinweb/pi-subagents` 已在已安装扩展列表。
- 在 pi 会话中询问「你可以派发子代理吗」，确认相关子代理工具/指令可用。

## Activate

按子代理扩展提供的技能/指令使用。典型用法是你向 pi 提出一个可分解的任务，pi 分派多个子代理并行处理后再汇总。具体调用方式因扩展实现而异，参考该扩展的 README 或 pi 内置说明。

## 卸载

```bash
pi remove npm:@tintinweb/pi-subagents
# 或轻量版
pi remove npm:pi-subagents-lite
```