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

### 步骤 3 —— 配置模型并选装扩展

1. 配置模型供应商与鉴权（`models.json` / `auth.json` / `settings.json`）：见 [docs/installation-models.md](docs/installation-models.md)。
2. 按需安装扩展与技能，从推荐基线挑选：见 [docs/installation.md](docs/installation.md#3-选装扩展与技能)。

---

## 文档地图

| 文档 | 内容 |
|---|---|
| [docs/installation.md](docs/installation.md) | 核心三步 + 扩展索引（主文档） |
| [docs/installation-models.md](docs/installation-models.md) | 模型供应商通用模板与鉴权 |
| [docs/installation-mcp.md](docs/installation-mcp.md) | MCP 服务器（exa / context7 / searchcode 等）|
| [docs/installation-codegraph.md](docs/installation-codegraph.md) | codegraph 代码理解 |
| [docs/installation-subagents.md](docs/installation-subagents.md) | pi-subagents 多代理 |
| [docs/installation-permission-system.md](docs/installation-permission-system.md) | pi-permission-system 权限管控 |
| [docs/installation-sol-pi.md](docs/installation-sol-pi.md) | SoL-Pi 长上下文 |
| [docs/installation-rtk-optimizer.md](docs/installation-rtk-optimizer.md) | pi-rtk-optimizer Token 优化 |
| [docs/installation-open-tui.md](docs/installation-open-tui.md) | pi-open-tui 交互界面 |
| [docs/installation-deepseek-cache.md](docs/installation-deepseek-cache.md) | pi-deepseek-cache 缓存加速 |
| [docs/installation-matt-pocock-skills.md](docs/installation-matt-pocock-skills.md) | mattpocock skills 技能集 |
| [docs/installation-theme.md](docs/installation-theme.md) | 主题 / 美化 |

### 场景索引

- **想快速装全一套** → 见 [docs/installation.md](docs/installation.md#3-选装扩展与技能) 的「推荐部署基线」。
- **只想先跑起来** → 完成上面的三步走即可。
- **想看全部可选扩展** → 见 [docs/installation.md](docs/installation.md#扩展完成索引) 的下表。

---

## 目录结构

```
kickstart.pi/
├── README.md
├── .gitignore
├── CONTEXT.md                  # 术语表
├── scripts/
│   └── kickstart-install.sh    # 一键铺装脚本（fresh / merge）
└── docs/
    ├── installation.md
    ├── installation-*.md       # 每个扩展/主题一篇
    └── adr/                    # 决策记录
```

## 维护约定

- **新增扩展 / 技能**：按 `docs/installation-<name>.md` 的模式新增一篇文档（含 Install / Verify / Activate / Uninstall），并在 `docs/installation.md` 的索引表登记。
- **不要写真实密钥**：模板一律用占位符，密钥由读者自行填到 `auth.json` 或对应文件的鉴权字段。
- **model 变更**：如需替换模型供应商，只改 `models.json` 通用模板示例，不绑定具体厂商。