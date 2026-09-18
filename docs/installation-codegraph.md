# 代码理解：codegraph

codegraph 为 pi 提供**语义代码搜索、调用图、变更影响分析**与深度代码探索能力，避免在处理大型代码库时反复落到慢速的 `grep` / `read` 循环上。

> 来源：官方包 `pi-codegraph-extension`（npm），配合 `@colbymchenry/codegraph` 使用。

---

## 1. 安装

### 1.1 安装 codegraph 本体（命令行）

先在系统全局安装 codegraph，或在要分析的项目中安装：

```bash
# 全局安装（任意目录可用）
npm install -g @colbymchenry/codegraph

# 或仅在要分析的项目内安装
npm install -D @colbymchenry/codegraph
```

### 1.2 安装 pi 扩展

```bash
pi install npm:pi-codegraph-extension
```

### 1.3 初始化项目索引

在要分析的项目目录下初始化索引：

```bash
cd /path/to/project
codegraph init -i
codegraph status
```

> 之后从**同一个 shell** 启动 pi（让它继承 `PATH`），pi 才能找到 codegraph 命令。

## 2. 可选环境变量（按需配置）

```bash
export CODEGRAPH_COMMAND=codegraph
export CODEGRAPH_ARGS="serve --mcp"
export CODEGRAPH_TIMEOUT_MS=30000
```

## 3. Verify

安装后确认扩展加载成功，且项目已建立 index。可让 pi 调用以下任一工具验证：

- `codegraph_status` —— 查看 codegraph 状态
- `codegraph_files` —— 浏览项目文件
- `codegraph_search` —— 语义搜索
- `codegraph_context` —— 获取上下文
- `codegraph_callers` / `codegraph_callees` —— 调用关系
- `codegraph_impact` —— 变更影响分析
- `codegraph_node` / `codegraph_explore` —— 代码节点与探索

## 4. Activate

- 在项目根目录确保已 `codegraph init -i` 建立索引。
- 从项目所在 shell 启动 pi，使 `PATH` 包含 codegraph。
- 在 pi 中发出结构性问题（如「谁调用了某个函数」「改动这个会影响哪里」），验证 codegraph 生效而未回退到 grep。

> **Tools 使用提示**：调用 `codegraph_files` 时给**相对仓库路径**过滤器（如 `src`、`app`），不要传整个项目根；项目根用 `projectPath`。

## 5. 卸载

```bash
# 移除 pi 扩展
pi remove npm:pi-codegraph-extension

# 移除项目内 codegraph（可选）
npm uninstall -D @colbymchenry/codegraph
# 或全局
npm uninstall -g @colbymchenry/codegraph
```