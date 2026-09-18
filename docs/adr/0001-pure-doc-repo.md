# ADR 0001：仓库定位为纯部署教程文档库

- **状态**：已接受
- **日期**：2026-09-17（决策完成时）

## 背景

原仓库 `/mnt/d/kickstart.pi` 是一个 Matt Pocock 风格 agent 技能脚手架（AGENTS.md + `docs/agents/` 三份技能文档）。用户决定将该仓库重构为一份"数据自己的 Pi Agent 部署教程文档"，仿照或ionpax1997/kickstart.pi 的项目结构。

## 决策

1. 仓库只承载**部署教程文档**（纯中文），不再承载 agent 技能约定。
2. 删除既有 `AGENTS.md` 与 `docs/agents/`（issue-tracker / triage-labels / domain）三份文档。
3. 本仓库默认不含 `AGENTS.md`（纯文档库，无需为项目内 agent 配置指令）。
4. 只提供 `.gitignore`，不提供 LICENSE。

## 后果

- 历史脚手架内容被移除；需明确告知用户，避免误删他人所需内容。
- 仓库内容单一聚焦，便于作为团队部署参考。