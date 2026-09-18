# 术语表（CONTEXT）

`kickstart.pi` 是一个面向 **Pi Coding Agent** 的部署教程仓库。本表收录教程中使用的专有术语，避免表达漂移。本文件只含术语，不含实现细节。

## 核心主体

- **pi / pi-agent / Pi Coding Agent**：由 `@earendil-works/pi-coding-agent` 提供的命令行终端 AI 编程代理（CLI）。本教程的部署对象。
- **pi 本体**：pi 的运行时（npm 全局包 `@earendil-works/pi-coding-agent`）。
- **配置目录**：pi 的全局配置与状态所在目录，默认 `~/.pi/agent`。
- **项目配置目录**：项目本地的 pi 配置与状态目录，默认项目根 `.pi/`。

## 配置与文件

- **models.json**：`~/.pi/agent/models.json`，定义模型供应商（vendor）与其下模型列表。
- **settings.json**：`~/.pi/agent/settings.json`，全局设置：主题、已装扩展包（`packages`）、默认模型（`defaultProvider` / `defaultModel`）、启用的模型列表（`enabledModels`）。
- **auth.json**：`~/.pi/agent/auth.json`，存放各服务的鉴权密钥/令牌（apiKey 等）。
- **mcp.json**：`~/.pi/agent/mcp.json`，MCP 服务器配置清单。
- **AGENTS.md**：给项目内 agent 的指令文件（本仓库定位为纯文档库，默认不放置）。
- **provider（模型供应商）**：models.json 里的一个命名端点，含 `baseUrl`、`api` 协议、`apiKey`、`models`。
- **扩展包（extension/package）**：可通过 `pi install` 安装的功能扩展，来源可为 `npm:`、`git:`、本地路径、URL。

## 安装与部署语义

- **覆盖部署（fresh）**：将本仓库配置整体铺到目标机器，假定无既有配置。
- **合并部署（merge）**：保留目标机器既有的 `~/.pi/agent` 已有文件，只补充缺失项，不覆盖已有内容（参考 `cp -an` 语义）。
- **已验证版本**：教程撰写时验证通过的 pi 版本基线。