# 技能集：mattpocock skills

mattpocock skills（来自 `mattpocock/skills` 仓库）提供一组**工程化提示技能**（如 grilling、tdd、diagnosing-bugs、code-review 等），让 pi 具备结构化的最佳实践能力。

---

## Install

两种安装路径，按你的环境选用：

### 方式 A：pi 侧直接安装（来源为 git 仓库）

```bash
pi install git:github.com/mattpocock/skills
```

安装完成确认出现在 `pi list`。技能通常以软链/目录形式位于 `~/.pi/agent/skills` 下。

### 方式 B：官方推荐的通用用法（不限于 pi）

```bash
# Claude 插件方式
claude plugins install mattpocock-skills

# 或 skills CLI
npx skills@latest add mattpocock/skills
```

> 两种方式都可行，按你实际使用的 agent 生态选择。若你的 pi 环境已经通过 `~/.agents/skills` 软链加载技能，用方式 A 更直接。

## Verify

- `pi install git:github.com/mattpocock/skills` 后，查看 `~/.pi/agent/skills`（或对应的技能加载目录），确认技能目录已出现。
- 在 pi 中询问「你有哪些可用技能」，确认技能被加载。

## Activate

- 技能按名称调用（如「grill me」「tdd」「diagnose this」）。触发对应技能的提示词即可让 pi 进入对应技能模式。
- 若技能未自动激活，检查技能目录是否在 pi 的技能加载路径内，必要时重启 pi。

## 卸载

```bash
# 方式 A
pi remove git:github.com/mattpocock/skills

# 方式 B
claude plugins uninstall mattpocock-skills
# 或
npx skills@latest remove mattpocock/skills
```

删除技能目录中的对应软链（可选）并重启 pi。