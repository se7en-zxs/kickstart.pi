#!/usr/bin/env bash
#
# kickstart-install.sh — Pi Coding Agent 基础配置铺装脚本
#
# 职责：把 pi 的基础配置骨架铺到目标配置目录（默认 ~/.pi/agent），
#       保证 pi 首次运行时有一个可用的配置起点。
# 本脚本【只做文件铺装】；不执行 `pi install` 安装扩展，
#       扩展请按 docs/installation-*.md 文档手动安装，以便步骤可审计。
#
# 用法：
#   bash scripts/kickstart-install.sh --fresh   # 全新部署：直接写骨架（假定无既有配置）
#   bash scripts/kickstart-install.sh --merge   # 已有环境：保留既有配置，只补缺失项
#
# 注意：
#   - 脚本生成的 models.json 是【通用骨架】，不含任何真实 key，
#     模型供应商请按 docs/installation-models.md 文档自行填写。
#   - 不会覆盖你已有的配置文件中已存在的内容（merge 模式）。

set -euo pipefail

PI_AGENT_DIR="${PI_AGENT_DIR:-$HOME/.pi/agent}"
MODE="${1:-}"

usage() {
  cat <<'EOF'
用法：
  bash scripts/kickstart-install.sh --fresh   全新部署（若配置目录不存在，直接创建骨架）
  bash scripts/kickstart-install.sh --merge    已有环境（补缺缺失项，不覆盖已有文件）
EOF
  exit 1
}

case "${MODE}" in
  --fresh) ;;
  --merge) ;;
  *) usage ;;
esac

echo "==> 目标配置目录: ${PI_AGENT_DIR}"
mkdir -p "${PI_AGENT_DIR}"

# 铺写 settings.json —— 轮询：fresh 则直接写；merge 则存在时不覆盖
write_settings() {
  local path="${PI_AGENT_DIR}/settings.json"
  if [ -f "${path}" ] && [ "${MODE}" = "--merge" ]; then
    echo "    settings.json 已存在 (merge 模式)，保留原有配置。"
    return 0
  fi
  cat > "${path}" <<'JSON'
{
  "theme": "light",
  "packages": [],
  "defaultProvider": "",
  "defaultModel": "",
  "defaultThinkingLevel": "medium",
  "enabledModels": []
}
JSON
  echo "    [写] settings.json（骨架）—— 请按 docs/installation-models.md 补填模型与启用列表。"
}

# models.json —— 通用占位骨架（不含任何真实 key）
write_models() {
  local path="${PI_AGENT_DIR}/models.json"
  if [ -f "${path}" ] && [ "${MODE}" = "--merge" ]; then
    echo "    models.json 已存在（merge 模式），保留原有配置。"
    return 0
  fi
  cat > "${path}" <<'JSON'
{
  "providers": {
      "my-provider": {
          "baseUrl": "https://YOUR_VENDOR_ENDPOINT/v1",
          "api": "openai-completions",
          "apiKey": "",
          "models": [
              { "id": "your-model-id", "name": "Your Model", "contextWindow": null, "maxTokens": null }
          ]
      }
  }
}
JSON
  echo "    [写] models.json（占位模板：baseUrl/apiKey/模型均需按文档替换）。"
}

# mcp.json —— 若不存在则不生成，避免误导（MCP 按各服务器官方配置，见 docs/installation-mcp.md）
write_mcp() {
  local path="${PI_AGENT_DIR}/mcp.json"
  if [ -f "${path}" ]; then
    echo "    mcp.json 已存在，保留。"
    return 0
  fi
  if [ "${MODE}" = "--fresh" ]; then
    cat > "${path}" <<'JSON'
{
  "mcpServers": {}
}
JSON
    echo "    [写] mcp.json（空骨架：需按 docs/installation-mcp.md 与各服务器官方文档配置）。"
  else
    echo "    mcp.json 不存在且为 merge 模式，跳过（不会凭空创建），请按需自行创建。"
  fi
}

write_settings
write_models
write_mcp

echo
echo "==> 铺装完成。"
echo "    下一步："
echo "      1) 按 docs/installation-models.md 填写模型供应商与鉴权；"
echo "      2) 按 docs/installation.md 安装需要的扩展与技能（pi install ...）。"