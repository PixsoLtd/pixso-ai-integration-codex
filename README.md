# Pixso AI Integration for Codex

Pixso AI Integration for Codex 是面向 OpenAI Codex 的本地 Pixso 插件包。它把 Pixso MCP、Design-to-Code、Code-to-Design、设计编辑和组件解析配置工作流打包成 Codex plugin，可在 Codex app、Codex CLI 和支持 Codex plugin directory 的本地工作流中使用。

Claude Code、Cursor 和 Gemini CLI 用户请使用多平台仓库：[PixsoLtd/pixso-ai-integration](https://github.com/PixsoLtd/pixso-ai-integration)。

## 插件内容

```text
.agents/plugins/marketplace.json          Repo-scoped Codex marketplace
plugins/pixso/.codex-plugin/plugin.json   Codex plugin manifest
plugins/pixso/plugin.lock.json            Plugin lock / skill registration
plugins/pixso/.mcp.json                   Pixso MCP server config
plugins/pixso/commands/                   Codex command definitions
plugins/pixso/skills/                     Pixso skills
plugins/pixso/scripts/                    Validation and MCP health-check scripts
```

当前包含 4 个 skills：

| Skill | 用途 |
| --- | --- |
| `pixso-design-to-code` | 将 Pixso 节点、页面、组件或 URL 转成目标框架代码，并做资源本地化和安全 cleanup。 |
| `pixso-code-to-design` | 将网页 URL、HTML、ZIP 或静态 Web 产物导入 Pixso，优先走精确 capture + `code_to_design`。 |
| `pixso-design-editing` | 在 Pixso 内创建、修改、检查和优化 UI 设计稿。 |
| `pixso-component-config` | 生成或更新 Pixso Design-to-Code 的 `componentParsers` / component config JSON。 |

当前包含 1 个 command：

| Command | 用途 |
| --- | --- |
| `/pixso-d2c-plus-config` | 调用 `pixso-component-config`，生成或更新 Design-to-Code 组件解析配置。 |

Codex 专属差异：

- `plugins/pixso/agents/openai.yaml` 和 skill 内的 `agents/openai.yaml` 只保留在 Codex 包内，用于 Codex/OpenAI agent wrapper。
- `plugin.lock.json` 明确注册可用 skill 列表。
- `.agents/plugins/marketplace.json` 让本仓库可以作为 Codex marketplace 安装源。

## 前置要求

1. 安装 Pixso Desktop。
2. 打开目标 Pixso 文件。
3. 启动 Pixso MCP 服务，默认地址为：

```text
http://localhost:3667/mcp
```

4. 安装并登录 Codex CLI / Codex app。

如果 Pixso MCP 地址不是默认值，请修改：

```text
plugins/pixso/.mcp.json
```

## 方式一：从 GitHub marketplace 安装

Codex 支持从 GitHub 仓库添加 plugin marketplace。添加本仓库：

```bash
codex plugin marketplace add PixsoLtd/pixso-ai-integration-codex
```

检查 marketplace：

```bash
codex plugin marketplace list
```

安装 Pixso plugin：

```bash
codex plugin add pixso@pixso
```

安装后启动一个新 Codex thread，再让 Codex 使用 Pixso plugin。新 thread 是推荐边界，能确保新 skills、commands 和 MCP 配置被加载。

## 方式二：从本地 clone 安装

```bash
git clone https://github.com/PixsoLtd/pixso-ai-integration-codex.git
cd pixso-ai-integration-codex
```

把本地仓库作为 marketplace 源添加：

```bash
codex plugin marketplace add .
codex plugin add pixso@pixso
```

Windows PowerShell 示例：

```powershell
git clone https://github.com/PixsoLtd/pixso-ai-integration-codex.git D:\AI\pixso-ai-integration-codex
cd D:\AI\pixso-ai-integration-codex
codex plugin marketplace add .
codex plugin add pixso@pixso
```

## 在 Codex app 中安装

如果你使用 Codex app：

1. 先用 CLI 添加 marketplace：

```bash
codex plugin marketplace add PixsoLtd/pixso-ai-integration-codex
```

2. 打开 Codex app 的 Plugins / Plugin Directory。
3. 在 marketplace 中找到 `Pixso`。
4. 选择安装。
5. 新开一个 thread 使用插件。

## 配置 Pixso MCP

默认配置：

```json
{
  "mcpServers": {
    "pixso": {
      "type": "http",
      "url": "http://localhost:3667/mcp"
    }
  }
}
```

配置文件位置：

```text
plugins/pixso/.mcp.json
```

如果你的 Pixso MCP 运行在其他端口，修改该文件后重新安装或重新加载插件。

检查 MCP 是否可达：

```powershell
.\plugins\pixso\scripts\check_mcp_server.ps1
```

或：

```powershell
Invoke-WebRequest -UseBasicParsing -Method Head -Uri "http://localhost:3667/mcp"
```

## 更新插件

### GitHub marketplace 安装

刷新 marketplace：

```bash
codex plugin marketplace upgrade pixso
```

重新安装或更新插件：

```bash
codex plugin add pixso@pixso
```

然后新开一个 Codex thread。

### 本地 clone 安装

```bash
cd <repo>
git pull
codex plugin add pixso@pixso
```

然后新开一个 Codex thread。

## 校验插件结构

本地开发或排查时可以运行：

```powershell
.\plugins\pixso\scripts\validate_pixso_plugin.ps1
```

它会检查：

- `plugins/pixso/.codex-plugin/plugin.json`
- `plugins/pixso/.mcp.json`
- `plugins/pixso/skills/`

## 使用方式

安装后，你可以直接让 Codex 使用 Pixso。

### 设计转代码

```text
Use Pixso to convert this selected frame to React code and save all generated assets locally.
```

也可以给 Pixso URL：

```text
Convert this Pixso URL to Vue code: <Pixso node URL>
```

### 网页或 HTML 导入 Pixso

```text
Import this page into Pixso as editable design nodes: https://example.com
```

如果页面需要登录、权限、区域访问或资源不可抓取，Codex 会先报告阻塞点，不会自动降级成近似重建设计。

### Pixso 设计编辑

```text
Create a dashboard screen in the current Pixso file using the existing design tokens and components.
```

```text
Refine the selected Pixso frame: improve spacing, hierarchy, and visual consistency.
```

### 组件解析配置

使用 command：

```text
/pixso-d2c-plus-config
```

或直接说：

```text
Use pixso-component-config to generate componentParsers for the current Pixso component library and Element Plus.
```

## 常见问题

### 安装后看不到 Pixso plugin

1. 检查 marketplace 是否存在：

```bash
codex plugin marketplace list
```

2. 检查 plugin 是否安装：

```bash
codex plugin list
```

3. 确认安装后新开了 thread。

### 看不到 `/pixso-d2c-plus-config`

重新安装插件并新开 thread：

```bash
codex plugin add pixso@pixso
```

### Pixso MCP 不可达

确认 Pixso Desktop 正在运行，目标文件已打开，且 MCP 服务地址与 `plugins/pixso/.mcp.json` 一致。

### 旧的 `pixso-design` 还出现

当前版本使用 `pixso-design-editing`。如果仍看到 `pixso-design`，通常是旧插件缓存或旧 thread：

1. 运行 `codex plugin marketplace upgrade pixso`。
2. 运行 `codex plugin add pixso@pixso`。
3. 新开 thread。

## 参考

- Codex plugins：[Plugins - Codex](https://developers.openai.com/codex/plugins)
- Codex plugin build guide：[Build plugins - Codex](https://developers.openai.com/codex/plugins/build)
- Codex CLI plugin commands：[Command line options - Codex CLI](https://developers.openai.com/codex/cli/reference)
