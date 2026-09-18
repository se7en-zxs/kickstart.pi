# 模型供应商与鉴权（`models.json` / `auth.json`）

pi 的模型能力来自你配置的**模型供应商**。所有供应商、模型、默认模型都在 `~/.pi/agent` 的配置中定义。本文提供**通用模板**（不含任何厂商真实端点与密钥），并讲解鉴权与模型选择链路。你不必绑定某一家厂商，按自己团队的供应情况填写即可。

---

## 1. 相关文件

| 文件 | 作用 |
|---|---|
| `~/.pi/agent/models.json` | 定义模型供应商（vendor）及其下模型列表 |
| `~/.pi/agent/settings.json` | 全局设置，包含默认模型与已启用模型 |
| `~/.pi/agent/auth.json` | 存放鉴权令牌（apiKey 等） |

## 2. models.json 通用模板

`models.json` 顶层是一个 `providers` 对象，每个键是一个**供应商名**，值为该供应商的端点与模型列表。字段说明：

| 字段 | 说明 |
|---|---|
| `baseUrl` | 供应商 API 的 base URL（OpenAI 兼容接口）|
| `api` | 接口协议，通常为 `openai-completions` |
| `apiKey` | 鉴权密钥（见下「鉴权方式」） |
| `models` | 该供应商下的模型数组，每项含 `id` / `name` 及可选 `contextWindow` / `maxTokens` |

```jsonc
{
  "providers": {
    "my-provider": {
      "baseUrl": "https://YOUR_VENDOR_ENDPOINT/v1",
      "api": "openai-completions",
      "apiKey": "<你的-apiKey-或留空走auth.json>",
      "models": [
        {
          "id": "your-model-id",
          "name": "Display Name",
          "contextWindow": 1048576,
          "maxTokens": 384000
        }
      ]
    }
  }
}
```

> **占位提示**：`YOUR_VENDOR_ENDPOINT` 与模型 id 为示例占位，请替换为你的供应商真实参数。本模板**不自带任何真实密钥**。

## 3. 鉴权方式：两种常用做法

### 3.1 方案 A：apiKey 直接写在 models.json

把 apiKey 直接写进 `models.json` 供应商里（如上面模板所示）。简单直接，但密钥以明文保存在配置目录。

### 3.2 方案 B：apiKey 放入 auth.json（推荐）

更安全的方式是把密钥集中放到 `~/.pi/agent/auth.json`，而 models.json 里的 apiKey 用空值或引用。

`auth.json` 结构（按供应商组织）：

```jsonc
{
  "my-provider": {
    "apiKey": "<你的真实apiKey>"
  }
}
```

> **注意**：`auth.json` 的具体键名/结构与 pi 版本相关，建议以你的 pi 版本在 `~/.pi/agent` 生成的样例为准。若确认某种写法，可在官方文档或 `pi` 交互中验证。

## 4. 模型选择链路（settings.json）

`models.json` 定义好供应商后，需要通过在 `~/.pi/agent/settings.json` 中设置**默认模型**与**启用模型**：

| 字段 | 作用 | 示例 |
|---|---|---|
| `defaultProvider` | 默认使用的供应商名 | `"my-provider"` |
| `defaultModel` | 默认使用的模型名 | `"Display Name"` |
| `defaultThinkingLevel` | 默认推理强度 | `"medium"` |
| `enabledModels` | 允许选用的模型列表 | `["my-provider/your-model-id", ...]` |

settings.json 简化示例：

```jsonc
{
  "theme": "light",
  "defaultProvider": "my-provider",
  "defaultModel": "your-model-id",
  "defaultThinkingLevel": "medium",
  "enabledModels": [
    "my-provider/your-model-id"
  ]
}
```

> 修改 `settings.json` 后需重启 pi 生效。若某个启用模型无法被识别，可先检查 supplier 名称与模型 id 拼写是否一致。

## 5. 常见问题

- **`No models match pattern` 警告**：多由于 `enabledModels` 里的 provider 名与 `models.json` 中的 vendor 名不一致，或该模型不在已声明的模型中。核对拼写即可。
- **无法联网**：检查 `baseUrl` 可达性，以及代理/env 是否影响。
- **apiKey 泄漏顾虑**：`~/.pi/agent` 属个人目录，仍建议 `auth.json` 追加到 `.gitignore` 类忽略，勿提交到版本库。

## 卸载

删除 `~/.pi/agent/models.json` 与 `auth.json` 中对应供应商片段即可移除某供应商；无需特殊卸载命令。