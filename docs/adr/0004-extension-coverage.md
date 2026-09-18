# ADR 0004：扩展详情覆盖范围与索引策略

- **状态**：已接受
- **日期**：2026-09-17（决策完成时）

## 背景

pi 生态有大量扩展。本教程需确定哪些扩展写详情、哪些只列名，形成团队的"部署基线"。

## 决策

1. **写详情（每个含 Install / Verify / Activate / Uninstall）**：
   - MCP 服务器（`pi-mcp-adapter` + exa / context7 / searchcode 等）
   - codegraph
   - subagents（`@tintinweb/pi-subagents` / `pi-subagents-lite`）
   - permission-system
   - SoL-Pi（`NVlabs/SoL-Pi` 长上下文）
   - pi-rtk-optimizer
   - pi-open-tui
   - pi-deepseek-cache（`@rohaquinlop/pi-deepseek-cache`）
   - mattpocock skills 技能集
   - 主题 / 美化（theme 等）

2. **不写详情**（openspec、superpowers、caveman、rounded-tools 等）：仅在 `docs/installation.md` 的总索引表中列名，并标注"见官方文档"。

3. **索引表**：`docs/installation.md` 提供可选扩展总索引，标注每项的详情链接或官方出处。

## 后果

- 团队有一条可复现的"推荐部署基线"。
- 未写详情的项保留在索引，读者可自取官方手册扩展。