# kickstart.pi

**Pi Coding Agent 部署教程** —— 一份面向团队的中文部署指南，把 pi 从零安装、铺装配置、再到逐个装好扩展/技能的标准流程写成可直接照做的文档。

> 本仓库定位为**纯文档库**，仿照 `orionpax1997/kickstart.pi` 的组织方式，但内容为数据中文团队的部署基线：**不含任何具体厂商密钥**，模型供应商做成通用模板，扩展按「一文一扩展」组织。

---

## 这是什么

- **Pi Coding Agent**：基于 Node 的命令行 AI 编程代理，由 `@earendil-works/pi-coding-agent` 提供。
- 本仓库不包含被 pi 直接加载的 agent 配置，而是一次**部署教程**：教你如何在本机/团队环境安装 pi、铺装配置、选装扩展。

---

## Quick Start（三步走通）

### 步骤 1 —— 安装 pi 本体

```bash
npm install -g --ignore-scripts @earendil-works/pi-coding-agent
pi --version
```

> 详细说明与 curl / npx 备选，见 [docs/installation.md](docs/installation.md#1-安装-pi-本体)。

### 步骤 2 —— 铺装配置文件

```bash
# 从本仓库
bash scripts/kickstart-install.sh --fresh   # 全新部署
# 已有环境请用 --merge（保留既有配置）
bash scripts/kickstart-install.sh --merge
```

> 合并（不覆盖既有配置）的安全语义与手动复制方法，见 [docs/installation.md](docs/installation.md#2-铺装配置文件)。

### 步骤 3 —— 配置全局行为与模型，选装扩展

1. **配置全局 AGENTS.md**，让 agent 思考与回答都使用中文：见 [docs/installation-agents.md](docs/installation-agents.md)。
2. 配置模型供应商与鉴权（`models.json` / `auth.json` / `settings.json`）：见 [docs/installation-models.md](docs/installation-models.md)。
3. 按需安装扩展与技能，从推荐的部署基线挑选：见 [docs/installation.md](docs/installation.md#3-选装扩展与技能)。

---

## 目录结构

本仓库是一个**页面式文档库**，每个核心文件都有明确职责：

| 路径 | 内容说明 |
|---|---|
| `README.md` | 本文件：项目简介 + 快速入门三步走 + 文档索引 |
| `.gitignore` | 忽略本地会话目录（`.pi/`）、临时文件（`*.swp`）、鉴权文件（`auth.json`）等 |
| `CONTEXT.md` | 术语表：全仓库核心主体与配置文件术语的统一定义 |
| `scripts/kickstart-install.sh` | 一键铺装脚本（`--fresh` 全新部署 / `--merge` 已有环境保留配置），铺出 `settings/models/mcp` 骨架与 MCP 三件套 |
| `docs/installation.md` | **核心文档**：三步完成部署 + 可选扩展「推荐部署基线」+ 全部扩展索引表 |
| `docs/installation-models.md` | 模型供应商通用模板、`auth.json` 鉴权、模型选择链路（`settings.json`）|
| `docs/installation-mcp.md` | **推荐必装**：MCP 三件套（exa / context7 / searchcode），含 `mcp.json` 配置、`AGENTS.md` 指引与接入任意第三方 MCP 的通用做法 |
| `docs/installation-agents.md` | 全局 AGENTS.md：中文语言要求（思考与回答） + MCP 指引 |
| `docs/installation-codegraph.md` | codegraph 代码理解：语义搜索 / 调用图 / 变更影响分析 |
| `docs/installation-subagents.md` | pi-subagents：Claude Code 风格自主子代理（完整）|
| `docs/installation-subagents-lite.md` | pi-subagents-lite：最小 token 开销的轻量子代理 |
| `docs/installation-permission-system.md` | pi-permission-system：allow / deny / ask 权限强制管控 |
| `docs/installation-sol-pi.md` | SoL-Pi：长上下文优化（压缩 / 打包）|
| `docs/installation-rtk-optimizer.md` | pi-rtk-optimizer：Token 消耗优化 |
| `docs/installation-open-tui.md` | pi-open-tui：终端 TUI 交互界面 |
| `docs/installation-deepseek-cache.md` | pi-deepseek-cache：DeepSeek 模型缓存加速 |
| `docs/installation-matt-pocock-skills.md` | mattpocock skills：`npx skills` 命令行安装的工程技能集（grilling / TDD / 调试 / 评审等）|
| `docs/installation-theme.md` | 主题 / 美化：界面观感调节 |

> 每个 `docs/installation-*.md` 都自含 **Install / Verify / Activate / Uninstall** 四个章节，可独立照做。

### 场景指引

- **想快速装全一套** → 见 [docs/installation.md](docs/installation.md#3-选装扩展与技能) 的「推荐部署基线」。
- **只想先跑起来** → 完成上面的三步走即可。
- **想看全部可选扩展** → 见 [docs/installation.md](docs/installation.md#扩展总索引) 的下表。

## 维护约定

- **新增扩展 / 技能**：按 `docs/installation-<name>.md` 的模式新增一篇扩展（含 Install / Verify / Activate / Uninstall），并在 `docs/installation.md` 的索引表登记。
- **不要写真实密钥**：模板一律用占位符，密钥由读者自行填到 `auth.json` 或对应文件的鉴权字段。
- **增量变更**：如需替换模型供应商，只改 `models.json` 通用模板示例，不指标具体厂商。
- **临时决策记录不提交**：仓库内开发过程中的 ADR（`docs/adr/`）为本地草稿，**不进入版本库**。