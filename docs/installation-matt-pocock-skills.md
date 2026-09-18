# 技能集：mattpocock skills

[mattpocock/skills](https://github.com/mattpocock/skills) 是由 Matt Pocock 整理的工程技能集（"Skills for Real Engineers"）——grilling 面试、TDD、调试、代码评审、架构调研、triage 等。技能按任务**自动加载**，其中一部分还注册为 `/skill:<name>` 命令。

---

## 安装（一行命令）

**cd 到项目目录**，然后运行：

```bash
npx skills@latest add mattpocock/skills --agent pi -y
```

安装器会拉取仓库、让你挑选要复制的技能，并写入**项目下的 `.pi/skills/<name>/`**；同时它还会在 `.agents/skills/` 放一份镜像副本，供其它遵循 Agent-Skills 规范的 agent 识别。

### 交互式挑选（不加 `-y`）

```bash
npx skills@latest add mattpocock/skills --agent pi
```

然后从多选提示里选你想要的技能。

### 常用参数

| 参数 | 作用 |
|---|---|
| `--agent pi` | 目标为 pi（写入 `.pi/skills/`）。省略则对每种受支持的 agent 安装 |
| `--skill <name>` | 只装某一个技能，可重复传。用 `'*'` 装全部 |
| `-y, --yes` | 跳过所有交互提示（非交互式）|
| `--list` | 只列出仓库里的技能，不安装 |

示例：

```bash
# 看看有哪些可用再动手
npx skills@latest add mattpocock/skills --list

# 只装 setup 向导 + 几个日常技能
npx skills@latest add mattpocock/skills --agent pi --skill \
  setup-matt-pocock-skills \
  grill-me \
  tdd \
  diagnosing-bugs \
  triage

# 全装
npx skills@latest add mattpocock/skills --agent pi --skill '*' -y
```

## 每个仓库的一次性配置

安装后，**每个项目**运行一次 `/skill:setup-matt-pocock-skills`。它问三个问题并写出配置文件：

1. **用哪个事务追踪？** GitHub、GitLab、Linear 或本地文件
2. **triage 标签用哪些？**（`/triage` 技能需要它们）
3. **领域文档（`CONTEXT.md`、ADR）放在哪？**

> 好些技能（`/triage`、`/to-spec`、`/to-tickets`、`/grill-with-docs`）都会读这段配置，所以这个 setup 向导实际上是前置步骤——安装时记得勾上它。

## 安装后得到什么

该仓库把技能分为两类：**用户主动调用**（只有你输入命令才触发，如 `/skill:grill-me`，编排工作流）和**模型自动调用**（任务匹配时可自动加载，承载可复用纪律）。

部分常用技能：

| 技能 | 触发 | 作用 |
|---|---|---|
| `grill-me` | `/skill:grill-me` | 在写任何代码前，用连续质询让计划/设计更锋利 |
| `grill-with-docs` | `/skill:grill-with-docs` | 与上面类似，但边做边构建 `CONTEXT.md` 和 ADR |
| `tdd` | 自动 + `/skill:tdd` | 针对功能与缺陷的红-绿-重构循环 |
| `diagnosing-bugs` | 自动 + `/skill:diagnosing-bugs` | 分阶段的、有纪律的调试循环 |
| `triage` | 自动 + `/skill:triage` | 把 issue 与外部 PR 走一遍 triage 状态机 |
| `code-review` | 自动 + `/skill:code-review` | 沿项目标准 + 规范两条轴评审改动 |
| `implement` | 自动 + `/skill:implement` | 依据规格或一组 tickets 实现一块工作 |
| `to-spec` | 自动 + `/skill:to-spec` | 把对话转成发布到 issue 系统的规格 |
| `to-tickets` | 自动 + `/skill:to-tickets` | 把一个计划拆成带显式阻塞边的贯穿性 tickets |
| `research` | 自动 + `/skill:research` | 对着一手资料调研问题，落成 Markdown |
| `prototype` | 自动 + `/skill:prototype` | 建一个可丢弃的原型来回答设计问题 |
| `wizard` | 自动 + `/skill:wizard` | 生成只留给人类执行的交互式 bash 向导 |

完整清单见 [skills.sh/mattpocock/skills](https://skills.sh/mattpocock/skills)。

## 推荐：项目级安装

- 技能绑定到**特定仓库的工作流**（这个 codebase 的 TDD、这个仓库 issue 的 triage、这个设计的架构）
- setup 向导写的是**每仓库配置**（issue 系统选择、标签词表、文档路径）——全局安装无法合理处理这些
- 技能落在 `.pi/skills/`，**与版本库友好**，你还能审查 diff
- `CONTEXT.md` / `CONTEXT/*.md` / `ADR-*.md` 产物本来也是项目本地文件
- 让无关项目不被技能建议污染

## 避免：全局安装

全局安装（去掉 `--agent pi` 且不传 `-g` 以避开项目级；或传 `-g` 用于 `~/`）会把每个技能加载进每个项目的每次会话，无论是否合适。**不推荐**——覆盖面积过大，且 setup 向导的每仓库配置在全局下不成立。

## 更新

仓库更新频繁，拉新版：

```bash
npx skills@latest update
```

会更新当前作用域（项目内为项目级，否则全局）下的技能，配 `-y` 可非交互。

## 作用域与卸载

mattpocock/skills 只写项目本地文件：

- `.pi/skills/<name>/SKILL.md`（及其附属资源）
- `.agents/skills/<name>/`（镜像副本）
- `/skill:setup-matt-pocock-skills` 后：`.agents/<repo>/` 配置文件

它不碰你的全局 `~/.pi/agent/`、模型设置、主题或其它项目。卸载：

```bash
npx skills@latest remove <name>
```

---

## Verify / Activate / Uninstall 小结

- **Verify**：`ls .pi/skills/` 确认技能目录出现；在 pi 中问「你有哪些技能」确认已加载。
- **Activate**：技能按名称触发（`/skill:grill-me` 或自动匹配），每项目先跑一次 `/skill:setup-matt-pocock-skills`。
- **Uninstall**：`npx skills@latest remove <name>`。