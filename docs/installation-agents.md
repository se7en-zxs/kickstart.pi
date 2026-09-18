# Agent 行为配置：全局 AGENTS.md（中文语言要求 + MCP 指引）

pi 的**行为偏好**集中写在全局 `~/.pi/agent/AGENTS.md`。本仓库建议在这个文件里放两件事：

1. **中文语言要求**——让 agent 在**内部思考与最终回答**都使用中文。
2. **MCP 使用指引**——告诉 pi 何时用什么 MCP 工具（联网、库文档、代码搜索）。

> 若 `AGENTS.md` 已存在，请**追加**而非整体覆盖；若相同内容已存在，不要重复。修改后重启 pi 或 `/reload` 生效。

## 一、中文语言要求（必配）

在 `~/.pi/agent/AGENTS.md` 顶部加入以下内容，让 agent 始终用中文沟通：

```markdown
## 语言

- 我的默认语言是中文。
- 请在内部思考与最终回答时，都使用中文。
- 命令、变量名、报错原文等保留英文原文，不翻译。
```

> 这样 pi 的**思考过程**与**对外回复**都会使用你的默认语言，而不会因为提示词是英文就跟着用英文回复。若你想用其它语言，把上面改成对应语言即可。

## 二、MCP 使用指引（推荐）

在 `~/.pi/agent/AGENTS.md` 追加 MCP 指引（若已在 `installation-mcp.md` 做过，则跳过本段）：

```markdown
## MCP

- Use exa for web search (current information, news, facts).
- Use context7 to look up library and framework documentation.
- Use searchcode to search and analyze public git repositories.
```

> 这三台 MCP 是联网/查库/搜代码的入口，指引它们存在，agent 才知道该何时用哪一个。详细安装见 [installation-mcp.md](installation-mcp.md)。

## 参考：其它常见偏好（可选）

全局 AGENTS.md 还可追加：工作风格、编码规范偏好、工具使用提示等对**所有项目**统一的约束。项目级偏好则在各仓库的 `AGENTS.md`（`<repo>/AGENTS.md`）里写，并在全局引用它（相对路径）以覆盖项目特例。

## Verify

在会话里问 pi 一个开放式问题（如「介绍一下你自己」），确认：

- **回答是中文**，且思考过程也遵循中文表达。
- 视觉上 MCP 指引生效：询问「你能用哪些工具」，确认 exa/context7/searchcode 可被调用。

## 卸载

- 语言要求：删除 `~/.pi/agent/AGENTS.md` 中的语言段落（或将语言改回其它）。
- MCP 指引：删除对应段落。

删除 `~/.pi/agent/AGENTS.md` 本身以移除全部全局行为偏好。