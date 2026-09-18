# 联网检索：MCP 服务器（exa / context7 / searchcode）

MCP（Model Context Protocol）让 pi 能调用外部工具服务器，实现联网搜索、库文档检索、公开仓库代码搜索等能力。本文安装三个**推荐必装**的搜索类 MCP——**exa**、**context7**、**searchcode**——并说明接入任意第三方 MCP 的通用做法。

> pi 原生架构并不以 MCP 为核心，而是围绕扩展/技能加载进自家进程。**为什么还要 MCP 桥？** 因为更广的 agent 生态（Context7、SearchCode、Exa 及多数第三方工具）都讲 MCP。`pi-mcp-adapter` 加几个 MCP server，就是让 pi 与该生态保持兼容的桥梁。

---

## 1. 安装 MCP 适配器

pi 通过 **pi-mcp-adapter** 与外部 MCP 服务器通信。先安装适配器扩展：

```bash
pi install npm:pi-mcp-adapter
```

> **Note**：pi 原生是没有 MCP 的。这个适配器包就是 pi 讲 MCP 话的翻译层，属于必备前提。

## 2. 在 mcp.json 声明三个 MCP 服务器

创建或更新 `~/.pi/agent/mcp.json`。**若文件已含其它 MCP 服务器，请把下列条目**合并**进其 `mcpServers` 对象，不要整体替换文件；若条目已存在，保留既有配置，避免重复。**

```json
{
  "mcpServers": {
    "exa": {
      "url": "https://mcp.exa.ai/mcp",
      "lifecycle": "eager"
    },
    "context7": {
      "url": "https://mcp.context7.com/mcp"
    },
    "searchcode": {
      "url": "https://api.searchcode.com/v1/mcp"
    }
  }
}
```

### 为什么 exa 用 `eager`？

联网搜索是全新会话里 pi 最常第一个去调的能力。**启动时就建连**（而不是等第一次工具调用才连），意味着等 pi 真正需要搜索时，连接已就绪。另外两个用默认的 `lazy`（用时再加载），因为它们只在明确的主动查询时才会触发。

### 三种服务器的用途

| MCP | URL | 用途 |
|---|---|---|
| **exa** | `https://mcp.exa.ai/mcp` | 联网/网页搜索（当前信息、新闻、事实）|
| **context7** | `https://mcp.context7.com/mcp` | 库与框架的最新文档检索 |
| **searchcode** | `https://api.searchcode.com/v1/mcp` | 公开 git 仓库与开源代码搜索 |

## 3. 配置 MCP 使用指引（AGENTS.md）

创建 `~/.pi/agent/AGENTS.md`，写入以下 MCP 使用指引。**若文件已存在，把这段追加进去而非覆盖**；若指引已在，不要重复。

> `exa` 放最前，因为新会话开头通常第一时间需要联网搜索。

```markdown
## MCP

- Use exa for web search (current information, news, facts).
- Use context7 to look up library and framework documentation.
- Use searchcode to search and analyze public git repositories.
```

> 这三台 MCP 正是全局 `AGENTS.md` 指引里指明的工具，没有它们那些指引就无处可查。

## 4. 已有其它 agent（Cursor / Claude Code / Codex）的 MCP 配置？

若你已在 Cursor / Claude Code / Codex 里配过 MCP，优先在任一 pi 会话里用 **`/mcp setup`** 导入它们，而不是手写 `mcp.json`。

## 5. 接入任意第三方 MCP（通用做法）

当你想接入更多第三方 MCP：

1. 查该工具官方提供的 MCP server `url`。
2. 在 `~/.pi/agent/mcp.json` 的 `mcpServers` 里新增一项，格式同上。
3. 是否需要 `eager` / 鉴权（`env` / header）按该工具官方说明。
4. 重启 pi，在对话中调用其工具验证。

> 第三方联网工具的 MCP server 各不相同，以各工具官方推荐为准。本文不内置任何第三方具体配置，避免与工具版本漂移。

## Verify / Activate

- 重启 `pi` 后，在会话里询问「你能用哪些 MCP 工具」，确认三个 server 出现。
- MCP 服务器随 pi 启动自动加载（`eager` 起连、`lazy` 用时连），无需额外激活。

## 卸载

- 移除某个 MCP：编辑 `mcp.json`，删除对应 `mcpServers` 条目即可。
- 移除适配器：`pi remove npm:pi-mcp-adapter`
- 同时清理 `AGENTS.md` 里对应 MCP 指引段落（可选），重启 pi 生效。