# ADR 0003：模型供应商做成通用模板，不绑定具体厂商

- **状态**：已接受
- **日期**：2026-09-17（决策完成时）

## 背景

本地 `models.json` 中配置了 `landi`（澜汐 N2.6，`https://zapi.avlcode.cn/v1`）、`amd`、`modelscope`、`agentrouter` 等多个供应商，且含真实 apiKey。该部署教程面向团队成员，可能使用不同厂商的关键模型。

## 决策

1. 教程 **不** 写入任何具体供应商的 `baseUrl` / 真实 apiKey。
2. 提供**通用 provider 模板**（vendor、`name`、`baseUrl`、`api`、`contextWindow`、`maxTokens` 字段，全部用占位符），供读者按自己的厂商填写。
3. 鉴权信息（apiKey）独立讲清楚：可写在 `models.json` 的 provider 里，或更推荐放入 `auth.json`，并给出说明。
4. 讲解"模型选择链路"：`models.json` 定义供应商 → `settings.json` 的 `defaultProvider` / `defaultModel` 选默认 → `enabledModels` 启用可用模型。

## 后果

- 教程通用不绑定厂商，避免暴露内部端点（含 `landi` 专属信息）。
- 读者需要自行向供应商申请 apiKey，并按其文档填 `baseUrl`。