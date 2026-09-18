# 缓存加速：pi-deepseek-cache

pi-deepseek-cache 针对 **DeepSeek** 系模型优化缓存命中率，减少重复计算的 token 开销，提升同样的上下文下的成本效率与响应速度。

> 来源：npm 包 `@rohaquinlop/pi-deepseek-cache`。

---

## Install

```bash
pi install npm:@rohaquinlop/pi-deepseek-cache
```

## Verify

- `pi list` 应出现 `@rohaquinlop/pi-deepseek-cache`。
- 确认已启用 DeepSeek 系模型（见 [installation-models.md](./installation-models.md)）。

## Activate

- 该扩展针对 DeepSeek 模型生效。使用 DeepSeek 系模型进行对话时，缓存命中路径应被激活。
- 视需要读取该扩展 README，确认是否要求额外环境变量或其它的缓存前缀设定。

## 卸载

```bash
pi remove npm:@rohaquinlop/pi-deepseek-cache
```

重启 pi 生效。