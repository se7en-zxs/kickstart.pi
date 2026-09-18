# ADR 0002：中文唯一 + 仿照参考项目分层结构

- **状态**：已接受
- **日期**：2026-09-17（决策完成时）

## 背景

仿照或ionpax1997/kickstart.pi 的文档组织方式，为本团队构建 pi 部署教程。参考项目采用"英文 `README.md` + 中文 `README.zh-cn.md`"的双语结构。经与用户讨论确认，本教程为数据中文团队的内部部署文档。

## 决策

1. **语言**：单一 `README.md`，纯中文编写。不维护双语版本。
2. **结构**（仿照参考项目）：
   - 根 `README.md` —— 项目简介 + Quick Start 三步走 + 链接到各详情文档。
   - `docs/installation.md` —— 核心三步部署主文档。
   - `docs/installation-<name>.md` —— 每个可选扩展一份独立文档。
   - `scripts/kickstart-install.sh` —— 可选的基础文件铺装脚本。
3. **Quick Start 策略**：README 里让读者能直接走通最小三步，并把每一步链接到 `docs/installation.md` 的对应详情。

## 后果

- 单一维护源，降低双语同步成本。
- 扩展按"一文一扩展"组织，后续新增扩展只需追加 `docs/installation-<name>.md` 并在索引登记。