# 联网检索：MCP 服务器（exa / context7 / searchcode）

MCP（Model Context Protocol）让 pi 能调用外部工具服务器，实现联网搜索、代码检索、API 查询等能力。本文以三个常用搜索类 MCP——**exa**、**context7**、**searchcode**——为例，说明如何为 pi 挂载外部 MCP 服务器。

> 如果你需要接入**其它第三方 MCP（含各类联网工具）**，本页「第 4 节」给出了通用做法，各工具的官方推荐为准。

---

## 1. MCP 在 pi 中的承载方式

- MCP 服务器配置写在 `~/.pi/agent/mcp.json`。
- pi 通过 **pi-mcp-adapter** 等适配器桥接外部 MCP 服务器，或在 `mcp.json` 中直接声明。
- 每个 MCP server 可设 `lifecycle`（`eager` / `lazy`）控制是否随 pi 启动即加载。

### 安装 pi-mcp-adapter（可选前提）

若你的 MCP 需要经过适配器挂载，可先用 pi 安装扩展：

```bash
pi install npm:pi-mcp-adapter
```

## 2. 推荐的三个联网 MCP

| MCP | 用途 | 类型 |
|---|---|---|
| **exa** | 面向「研究/搜索」的语义搜索引擎 | 搜索类 MCP |
| **context7** | 框架/库最新文档与上下文检索 | 文档类 MCP |
| **searchcode** | 代码片段与开源代码搜索 | 代码类 MCP |

> 三者共用「在 `mcp.json` 声明 server」的接入方式，仅 `baseUrl` / 鉴权不同。

## 3. 在 mcp.json 中声明 MCP 服务器

以 `mcp.json`（位于 `~/.pi/agent/mcp.json`）声明这三个 server，占位符替换为你的真实配置与密钥：

```jsonc
{
  "mcpServers": {
    "exa": {
      "command": "exa-mcp-server",           // 或用 npx
      "args": [],
      "env": {
        "EXA_API_KEY": "<你的-exa-apiKey>"
      }
    },
    "context7": {
      "command": "context7",
      "args": [],
      "lifecycle": "eager"                    // 可选：启动即加载
    },
    "searchcode": {
      "command": "searchcode-mcp",
      "args": [],
      "lifecycle": "lazy"                     // 可选：用时再加载
    }
  }
}
```

> **注意**：以上 `command` / `env` 字段为示例形态，不同 MCP 的实际启动命令与所需密钥不同。**务必以各 MCP 官方文档为准**（`exa`、`context7`、`searchcode` 各自的官方提供接入说明）。

## 4. 通用做法：接入任意第三方 MCP

当你想接入不在上表里的第三方 MCP（含联网检索工具）：

1. 查阅该工具官方提供的 MCP 接入文档，找到其 server 名称、启动命令、所需鉴权。
2. 在 `~/.pi/agent/mcp.json` 的 `mcpServers` 里新增一项。
3. 需要鉴权的密钥按官方指引放在 `env` / `auth.json` 对应位置。
4. 重启 pi，在对话中调用其工具验证。

> 本仓库文档**不内置**第三方联网 MCP 的名称配置，避免与各工具版本漂移；请以官方为准。

## 5. Verify / Activate

- **验证配置**：重启 `pi` 后，在 `.pi` 会话里询问 pi 「你能使用哪些 MCP 工具」，确认刚声明的 server 出现。
- **Activate**：多数 MCP 在 pi 中是自动激活的；部分需在 `settings.json` / 交互界面启用。

## 6. 卸载

- **移除某个 MCP**：编辑 `mcp.json`，删除对应 `mcpServers` 中的条目即可。
- **移除 pi-mcp-adapter 适配器**：`pi remove npm:pi-mcp-adapter`
- 删除相关配置文件后重启 pi 生效。