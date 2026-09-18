# Pi Coding Agent 部署教程（核心三步）

本文梳理把 **Pi Coding Agent** 从零安装到一台机器（或团队公共环境）上的**标准流程**。核心三步分别是：

1. **[安装 pi 本体](#1-安装-pi-本体)**
2. **[铺装配置文件](#2-铺装配置文件)**
3. **[选装扩展与技能](#3-选装扩展与技能)**

> **关于 MCP**：联网检索（exa / context7 / searchcode）三件套是关联部署的**推荐必装**，能立即获得联网搜索、库文档、开源代码检索能力（见 [installation-mcp.md](installation-mcp.md)）。若团队明确「离线自足」也可跳过，只是 pi 会少了联网工具。

> **关于语言**：若希望 agent 在**思考与回答时都使用中文**，请在全局 `~/.pi/agent/AGENTS.md` 声明中文为默认语言（见 [installation-agents.md](installation-agents.md)）。

每一步都可在单独的文章里展开；建议先完整读完本文，再根据团队的「部署基线」逐个安装需要的扩展。

> **约定**：下文以 `~/.pi/agent` 作为 pi 的全局配置目录（默认路径）。若你的环境中 pi 配置目录不同，请把命令中的路径替换成实际路径。

---

## 0. 前置条件

- **Node.js 环境**：pi 基于 Node 运行，需要能够执行 `npm`。
- **终端**：支持 pi 的交互式 TUI（Linux / macOS），Windows 亦可运行。
- **网络**：安装扩展与模型供应商时需访问 npm registry 与厂商 API。

---

## 1. 安装 pi 本体

### 方式 A：npm 全局安装（推荐）

```bash
npm install -g --ignore-scripts @earendil-works/pi-coding-agent
```

`--ignore-scripts` 用于禁用依赖生命周期脚本，pi 的正常安装不需要这些脚本。

> **注意**：安装命令中给出的包名为官方包名。安装完成后，`pi` 二进制应可用：

```bash
pi --version
```

### 方式 B：通过 curl 脚本 / npx 临时运行的备选

pi 本体也可以在未全局安装时用 `npx` 临时调用：

```bash
npx @earendil-works/pi-coding-agent --help
```

> 若要长期使用，`npx` 方案会在首次调用时下载，语义上不稳定，建议仍用**方式 A** 全局安装。

### 首次运行引导

首次运行 `pi` 会自动创建 `~/.pi/agent` 配置目录，并进入引导流程。运行一次即可完成初始化：

```bash
pi
```

初始化后，确认配置目录已生成：

```bash
ls -la ~/.pi/agent
# 期望看到 settings.json、models.json 等文件（若尚缺,后续步骤会自行补充）
```

---

## 2. 铺装配置文件

pi 的行为由 `~/.pi/agent` 下的几个 JSON 文件决定。本仓库提供两类配置模板，可按**部署场景**选择铺装方式：

| 场景 | 推荐策略 | 说明 |
|---|---|---|
| 全新机器（无既有 `~/.pi/agent`） | **覆盖（fresh）** | 尚无配置，直接铺装模板即可 |
| 已有环境（机器上装过 pi） | **合并（merge）** | 保留既有配置，只补充缺失项，**不覆盖**用户已有设置 |

> ⚠️ **动手前先留份备份**：无论选哪种方式，改动前建议先把既有配置挪走备一份，例如
> ```bash
> [ -d ~/.pi/agent ] && cp -r ~/.pi/agent ~/.pi/agent.bak
> ```
> 这样出错可一键回滚（`cp -an ~/.pi/agent.bak/. ~/.pi/agent/`）。

### 方式 A：使用一键脚本（推荐，见 `scripts/kickstart-install.sh`）

```bash
# 全新部署：覆盖铺装
bash scripts/kickstart-install.sh --fresh

# 已有环境：合并铺装（保留既有配置）
bash scripts/kickstart-install.sh --merge
```

脚本的功能与安全语义详见文末脚本章节（`scripts/kickstart-install.sh`），它会**内嵌生成**配置文件骨架到目标目录：`settings.json`、`models.json`（通用占位、不含真实 key）、`mcp.json`（MCP 三件套，见 [installation-mcp.md](installation-mcp.md)）。

### 方式二：手动复制（merge 语义）

若你想手动保留已有配置，可参考 `cp -an`（`-a` 归档、`-n` 不覆盖已有文件），把旧环境备份（如 `~/.pi/agent.bak/`）复制回去：

```bash
mkdir -p ~/.pi/agent
cp -an ~/.pi/agent.bak/settings.json ~/.pi/agent/settings.json
cp -an ~/.pi/agent.bak/models.json ~/.pi/agent/models.json
```

> ⚠️ **安全提示**：上面复制的应是**你自己备份的旧配置**，而非本仓库内容。本仓库不携带 `settings.json` / `models.json` 模板；模型供应商按 [installation-models.md](./installation-models.md) 自填或由 pi 首次运行向导生成。任何配置中都**不要写入真实 apiKey**，建议按 `auth.json` 方案填写。

---

## 3. 选装扩展与技能

pi 的能力通过 **扩展包** 与 **技能** 增强。扩展通过 `pi install` 加装，技能则按官方/社区方式安装。

> 提示：`pi install` 支持多种来源，常见语法见下：
> ```bash
> pi install npm:<包名>               # npm 包
> pi install git:github.com/owner/repo # git 仓库
> pi install ./local/path            # 本地路径
> ```
> 安装记录会写入 `~/.pi/agent/settings.json` 的 `packages` 数组，可用 `pi list` 查看。

### 3.1 推荐部署基线（本团队建议）

以下扩展/技能为本仓库**写有详细安装文档**的部分，按功能分类齐全：

| 类别 | 扩展/技能 | 安装文档 |
|---|---|---|
| 联网检索（必装） | MCP 服务器（exa / context7 / searchcode） | [installation-mcp.md](installation-mcp.md) |
| 全局行为（必装） | 全局 AGENTS.md（不含中文语言要求 + MCP 指引） | [installation-agents.md](installation-agents.md) |
| 代码理解 | codegraph | [installation-codegraph.md](./installation-codegraph.md) |
| 多代理（完整） | pi-subagents | [installation-subagents.md](./installation-subagents.md) |
| 多代理（轻量） | pi-subagents-lite | [installation-subagents-lite.md](./installation-subagents-lite.md) |
| 权限管控 | pi-permission-system | [installation-permission-system.md](./installation-permission-system.md) |
| 长上下文 | SoL-Pi | [installation-sol-pi.md](./installation-sol-pi.md) |
| Token 优化 | pi-rtk-optimizer | [installation-rtk-optimizer.md](./installation-rtk-optimizer.md) |
| 交互界面 | pi-open-tui | [installation-open-tui.md](./installation-open-tui.md) |
| 缓存加速 | pi-deepseek-cache | [installation-deepseek-cache.md](./installation-deepseek-cache.md) |
| 技能集 | mattpocock skills | [installation-matt-pocock-skills.md](./installation-matt-pocock-skills.md) |
| 外观 | 主题 / 美化 | [installation-theme.md](./installation-theme.md) |

### 3.2 扩展完整索引（含未写详情的项）

下表列出 pi 生态中常用的可选扩展。带「详情文档」的，本仓库已提供逐步安装说明；标注「见官方」的，建议直接查阅该工具官方手册。

| 扩展/软件 | 类别 | 说明 | 出处 |
|---|---|---|---|
| pi-mcp-adapter | 联网/MCP | MCP 服务器适配器，接入外部 MCP | 见官方 pi.dev |
| exa / context7 / searchcode | 联网/MCP | 推荐的搜索 MCP | [installation-mcp.md](./installation-mcp.md) |
| codegraph | 代码理解 | 语义代码搜索、调用图、变更影响分析 | [installation-codegraph.md](./installation-codegraph.md) |
| pi-subagents | 多代理 | Claude Code 风格自主子代理（完整） | [installation-subagents.md](./installation-subagents.md) |
| pi-subagents-lite | 多代理 | 最小 token 开销的子代理（轻量） | [installation-subagents-lite.md](./installation-subagents-lite.md) |
| @gotgenes/pi-permission-system | 权限 | 权限强制管控（allow/deny/ask） | [installation-permission-system.md](./installation-permission-system.md) |
| SoL-Pi | 长上下文 | 长上下文自演化优化 | [installation-sol-pi.md](./installation-sol-pi.md) |
| pi-rtk-optimizer | Token | RTK / token 优化 | [installation-rtk-optimizer.md](./installation-rtk-optimizer.md) |
| pi-open-tui | 交互 | 终端 TUI 界面 | [installation-open-tui.md](./installation-open-tui.md) |
| pi-deepseek-cache | 缓存 | deepseek 缓存命中 | [installation-deepseek-cache.md](./installation-deepseek-cache.md) |
| mattpocock skills | 技能 | 工程化提示技能集 | [installation-matt-pocock-skills.md](./installation-matt-pocock-skills.md) |
| 全局 AGENTS.md | 全局行为 | 中文语言要求 + MCP 指引 | [installation-agents.md](./installation-agents.md) |
| 主题 / 美化 | 外观 | 界面主题、美化 | [installation-theme.md](./installation-theme.md) |
| openspec | 规格 | OpenSpec 规范工作流 | 见官方 |
| superpowers | 技能 | 超能力技能集 | 见官方 |
| caveman | 技能 | 极简提示技能 | 见官方 |
| rounded-tools | 交互 | 圆角工具美化 | 见官方 |

> 上表为「可选扩展总索引」，仅供扩展规划参考；团队部署时不必全部安装，按「部署基线」挑选即可。

---

## 脚本：`scripts/kickstart-install.sh`

一键安装脚本的职责**仅为基础配置文件铺装**：在目标目录**内嵌生成**骨架（`settings.json`、`models.json`、含 MCP 三件套的 `mcp.json`）。它**不会**自动执行 `pi install` 安装扩展；扩展的 `pi install` 命令请按各 `installation-*.md` 文档手动执行，以保证步骤可审计。

```
用法：
  bash scripts/kickstart-install.sh --fresh   全新部署，直接覆盖铺装
  bash scripts/kickstart-install.sh --merge    已有环境，合并补缺不覆盖
```

> 脚本在无既有配置时等价于覆盖；检测到目标存在且未指定 `--fresh` 时建议用 `--merge`。

---

## 下一步

- **配置全局 AGENTS.md**（中文语言要求 + MCP 指引），见 [installation-agents.md](installation-agents.md)。
- 安装**联网 MCP 三件套**（exa / context7 / searchcode），见 [installation-mcp.md](installation-mcp.md)。
- 配置模型供应商与鉴权，见 [installation-models.md](installation-models.md)（含 `models.json` 通用模板与 `auth.json` 鉴权说明）。
- 完整了解各扩展，按「第 3 节」的表格逐个安装。

### 卸载（Uninstall）

- **pi 本体**：`npm uninstall -g @earendil-works/pi-coding-agent`
- **某个扩展包**：`pi remove npm:<包名>`（或 `pi install` 对应来源），再删掉 `~/.pi/agent/settings.json` 的 `packages` 对应项。
- **全部配置**：删除 `~/.pi/agent` 目录及 `~/.pi/cache`。

具体每个扩展的卸载步骤见各自文档的末尾「卸载」章节。