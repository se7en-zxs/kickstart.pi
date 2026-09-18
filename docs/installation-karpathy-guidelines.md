# 技能集：andrej-karpathy-skills

[andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) 是一组源自 **Andrej Karpathy 关于 LLM 编程常见错误的观察**的提示纪律技能，核心是 `karpathy-guidelines`（Karpathy 准则）。

它约束 agent 在**写代码、评审代码、重构代码**时的行为，用于减少 LLM 编码中的常见失误：过度设计（overcomplication）、外科手术式改动、暴露假设、以及把目标转成可验证的成功标准。适合作为**团队代码质量的兜底纪律**，与 `mattpocock skills` 中的 `code-review` / `tdd` 等配套使用。

---

## 它能管住什么

技能按任务**自动加载**（写 / 评审 / 重构时命中即可生效），核心是以下几条准则：

1. **先想后写（Think Before Coding）**——显式声明假设、不一言不发地替用户做选择、发现歧义就停下提问。
2. **简单优先（Simplicity First）**——只写解决问题的**最小代码**，不为单次用途造抽象，不做投机性的灵活性。
3. **外科手术式改动（Surgical Changes）**——只碰必须碰的行，不顺手"改进"相邻代码，不留孤儿 import；无关的死代码**只提不删**。
4. **目标驱动执行（Goal-Driven Execution）**——把"加校验"变成"先写测试再让它通过"，把"修 bug"变成"先写复现用例再让它通过"，并给出带 verify 步骤的简短计划。

> **权衡**：这套准则偏向**谨慎优先于速度**。对琐碎小任务可以酌情简化，不必死板套用。

---

## 安装

> 方式与 `mattpocock skills` 相同，都走 `npx skills` 安装器，把技能写入目标作用域的 `skills/` 目录。

### 项目级安装（推荐，与技能所属仓库解耦）

**cd 到项目目录**，运行：

```bash
npx skills@latest add multica-ai/andrej-karpathy-skills --agent pi -y
```

安装器会拉取仓库、让你挑选要复制的技能（默认勾选 `karpathy-guidelines`），并写入**项目下的 `.pi/skills/<name>/`**；同时 `.agents/skills/` 会放一份镜像副本，供其它遵循 Agent-Skills 规范的 agent 识别。

只装 `karpathy-guidelines` 单个技能：

```bash
npx skills@latest add multica-ai/andrej-karpathy-skills --agent pi --skill karpathy-guidelines
```

### 全局安装

若希望这套纪律**跨项目始终生效**，可用全局作用域安装：

```bash
npx skills@latest add multica-ai/andrej-karpathy-skills -g
```

> 全局 schema 沿用 `/root/.pi/agent/skills/` 这种结构时，本质是往全局 skills 目录落 SKILL.md。它与 mattpocock 技能不同——`karpathy-guidelines` **不需要任何按仓库的 setup 配置**，因此全局安装是一个合理选项（而 ``mattpocock`` 因每仓库配置不建议全局装）。

### 常用安装参数

| 参数 | 作用 |
|---|---|
| `--agent pi` | 目标为 pi（写入 `.pi/skills/`）。省略则对每种受支持的 agent 安装 |
| `--skill <name>` | 只装某一个技能，可重复传。用 `'*'` 装全部 |
| `-y, --yes` | 跳过所有交互提示（非交互式）|
| `-g` | 全局安装（写入全局 skills 目录）|
| `--list` | 只列出仓库里的技能，不安装 |

```bash
# 看看有哪些可用再动手
npx skills@latest add multica-ai/andrej-karpathy-skills --list
```

---

## 安装后得到什么

安装后得到技能 `karpathy-guidelines`，其 `SKILL.md` 挂在 `/root/.pi/agent/skills/` 或项目 `.pi/skills/`：

| 技能 | 触发 | 作用 |
|---|---|---|
| `karpathy-guidelines` | 自动（写 / 评审 / 重构代码时） | 四条编码纪律：先想再写 / 写简单 / 外科手术式改动 / 目标驱动执行 |

> 技能不挂 `/skill:` 命令（不靠主动触发），靠任务匹配自动加载，作为写代码时的**默认行为约束**。

---

## Verify / Activate / Uninstall 小结

- **Verify**：`ls .pi/skills/`（或 `ls ~/.pi/agent/skills/`）应出现 `karpathy-guidelines/` 目录。
- **Activate**：无需手动激活；写代码 / 评审 / 重构时被任务自动匹配调用。在 pi 中让它写一段改动，观察它是否先声明假设、只动必要行、且给出 verify 步骤。
- **Uninstall**：
  ```bash
  npx skills@latest remove karpathy-guidelines
  ```
  或按安装作用域删除对应的 `SKILL.md`。

---

## 与 mattpocock skills 的搭配

- `mattpocock skills` 偏**流程纪律**（TDD、drums、reviewing、triage 等）。
- `andrej-karpathy-skills` 偏**写码心智**（简洁、外科手术、成功标准）。
- 二者都自动加载、互不冲突。团队基线建议**同时装**，让"评审走哪条轴"（mattpocock `code-review`）与"单行改动怎么写"（karpathy-guidelines）各司其职。

---

## 参考

- 官方仓库：[multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills)
- Karpathy 原始观察：[x.com/karpathy 关于 LLM 编码陷阱的讨论](https://x.com/karpathy/status/2015883857489522876)