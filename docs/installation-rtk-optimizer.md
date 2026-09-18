# Token 优化：pi-rtk-optimizer

pi-rtk-optimizer 通过**重写（rewrite）/ 压缩输出、聚合命令输出、限制截断**等策略优化 token 使用，减少无价值输出对上下文的占用。

> 来源：npm 包 `pi-rtk-optimizer`。

---

## Install

```bash
pi install npm:pi-rtk-optimizer
```

## Verify

- `pi list` 应出现 `pi-rtk-optimizer`。
- 确认 `grep` 在 `~/.pi/agent` 下生成优化器的配置文件（通常位于该扩展目录下的 `config.json` 或 `~/.pi/agent`）。

## Activate / 配置

常见配置项（以扩展自带 `config.json` 为模板）：

```jsonc
{
  "mode": "rewrite",
  "enableOutputCompression": true,
  "truncate": {
    "maxChars": 12000
  },
  "smartTruncate": {
    "maxLines": 220
  },
  "aggregate": ["git", "build", "linter", "search"]
}
```

> 字段名与默认值以该扩展实际 `config.json` 为准。`mode` 常用 `rewrite`（重写压缩输出）。开启压缩后，长输出会被智能截断或重写，以节省上下文。

## 卸载

```bash
pi remove npm:pi-rtk-optimizer
```

重启 pi 生效。