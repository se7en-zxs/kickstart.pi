# 权限管控：pi-permission-system

pi-permission-system 为 pi 提供**权限强制管控**，用于约束 pi 能执行的操作（工具调用、命令、文件读写等），适合对安全敏感或需要审计的环境。

> 来源：npm 包 `pi-permission-system`。名称见官方 Pi 软件包目录。

---

## Install

```bash
pi install npm:pi-permission-system
```

安装后确认已写入 `~/.pi/agent/settings.json` 的 `packages`：

```bash
pi list
```

## Verify

- `pi list` 中应出现 `pi-permission-system`。
- 触发一条需权限的操作（如让 pi 修改系统文件），验证权限提示/策略是否按预期拦截或放行。

## Activate / Configure

- 权限策略（白名单、黑名单、确认策略）一般通过 pi 的全局/项目权限配置或该扩展的配置文件设定。
- 若你同时启用了全局与项目级权限策略，二者会**合并**生效；请知晓合并规则以免意外放行。

> 配置的具体文件路径与策略语法以该扩展官方 README 为准。建议在正式环境部署前先在测试目录验证策略符合预期。

## 卸载

```bash
pi remove npm:pi-permission-system
```

删除后权限管控失效，请确认这是你想要的。