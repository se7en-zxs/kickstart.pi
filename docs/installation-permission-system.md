# 权限管控：pi-permission-system

[@gotgenes/pi-permission-system](https://pi.dev/packages/@gotgenes/pi-permission-system) 是 pi 的权限强制管控扩展——它把**每个**工具、bash、MCP、技能、特殊操作都卡在一份策略文件上。三种状态（`allow` / `deny` / `ask`）加四个分层平面（`path` → `external_directory` → per-tool 模式 → `bash` 模式），覆盖了编码 agent 能做的绝大部分事；没被预先批准的会用 UI 确认弹窗。

> **为什么和 pi-subagents-lite 搭着用？** 当某个子代理想 `rm -rf` 时，你希望同一份策略也管住它。`@gotgenes/pi-permission-system` 会把**非 UI 子会话**的 `ask` 提示转发回父会话的询问框，于是子代理的操作也被同样的规则约束。把两者都装到全局级，它们开箱即协同。

## Install

```bash
pi install npm:@gotgenes/pi-permission-system
```

这会把扩展加进你的全局 pi 设置（`~/.pi/agent/settings.json`）。pi 启动时自动发现它。

> 建议在**全局级**安装：策略文件是 `~/.pi/agent/extensions/pi-permission-system/config.json`，作用于**每个会话**。项目级覆盖写在 `<cwd>/.pi/extensions/pi-permission-system/config.json`，且**只能收紧**全局规则（不能放松全局 `deny`）。

## Configure

创建全局策略文件 `~/.pi/agent/extensions/pi-permission-system/config.json`：

```jsonc
{
  "permission": {
    "*": "allow",
    "path": {
      "*": "allow",
      "*.env": "deny",
      "*.env.*": "deny",
      "*.env.example": "allow"
    },
    "bash": {
      "*": "ask",
      "rm -rf *": "deny",
      "sudo *": "ask"
    },
    "external_directory": "ask"
  }
}
```

然后重启 pi，或在会话内跑 `/reload`。

### 四个策略平面（Surface）各做什么

| 平面 | 作用 |
|---|---|
| `path` | **所有**文件访问的横向门禁（工具 + bash + MCP + 扩展）。放 `.env`、`~/.ssh/*` 这类规则的正确位置 |
| `external_directory` | 工作目录边界门禁——文件工具或 bash 触及工作树之外时先弹提示。可配模式映射，把特定 CWD 外目录（如 `~/.cargo/registry`）`allow` 白名单化 |
| `bash` | 命令模式匹配，支持 `*` 通配。**最后一条匹配的规则生效** |
| `*` | 上表未覆盖的一切的后备 |

四层按**最严格生效**组合：`path: "deny"` 不会被某工具级 `allow` 放松；`external_directory: "ask"` 不会被 `path: "allow"` 放松。完整平面清单与合并语义见 [Configuration reference](https://github.com/gotgenes/pi-permission-system/blob/main/docs/configuration.md)。

### 三种权限状态

| 状态 | 行为 |
|---|---|
| `allow` | 静默放行该动作 |
| `deny` | 阻止并返回错误信息给模型 |
| `ask` | 弹 UI 对话框；可批准一次，或批准一条模式供本会话剩余时间使用（见 [session approvals](https://github.com/gotgenes/pi-permission-system/blob/main/docs/session-approvals.md)）|

## Verify

在一个全新 `pi` 会话里：

1. 让 agent 执行 `cat ~/.ssh/id_ed25519` —— 应被 `path` 平面的 `deny` 拦下。
2. 让 agent 读 `../some-other-project/README.md` —— 应弹一个 `external_directory: ask` 对话框（因为它越出了 cwd）。
3. 让 agent 跑 `rm -rf node_modules` —— 应被 `bash: "rm -rf *": "deny"` 拦下。

若以上任何一项悄悄成功了，说明配置文件没被读到——检查路径（`~/.pi/agent/extensions/pi-permission-system/config.json`）且 JSON 能解析（`jq . ~/.pi/agent/extensions/pi-permission-system/config.json`）。

## Customize

- **项目级覆盖**：把 `config.json` 放进 `<cwd>/.pi/extensions/pi-permission-system/`。扩展只在目录被信任时才加载项目配置，所以不受信任的仓库无法放松你的全局策略。
- **按 agent 覆盖**：在全局 agent 定义（`~/.pi/agent/agents/<name>.md`）的 YAML frontmatter 里加角色化策略（如给 `explore` agent 更严的 bash 规则）。
- **模式**：`*` 是唯一通配符。在提示弹窗里批准一条相似命令后，对话框会提供生成好的规则（[pattern suggester](https://github.com/gotgenes/pi-permission-system/blob/main/docs/session-approvals.md#pattern-suggestions)）。

## Uninstall

```bash
pi remove npm:@gotgenes/pi-permission-system
```

删除 `~/.pi/agent/settings.json` 里的条目。**注意**：策略文件 `~/.pi/agent/extensions/pi-permission-system/config.json` 不会随卸载删除——想要全新起点，手动删：

```bash
rm -rf ~/.pi/agent/extensions/pi-permission-system
```

## Scope

该扩展只增加权限门禁、在 agent 启动前隐藏被禁用的工具、并把子会话（sub-agents）的 `ask` 提示转发回父会话 UI。它**不改变** pi 主 agent 的行为、系统提示词、默认工具列表、模型选择或会话生命周期——门禁移除后，pi 恢复成原来的样子。