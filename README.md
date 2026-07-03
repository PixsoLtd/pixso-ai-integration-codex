# Pixso AI Integration for Codex

Pixso AI Integration for Codex 是面向 OpenAI Codex 的 Pixso 本地 AI 插件。安装后，你可以让 Codex 读取 Pixso 设计、生成代码、把网页导入 Pixso、编辑设计稿，或生成 Design-to-Code 组件解析配置。

Claude Code、Cursor 和 Gemini CLI 用户请使用多平台仓库：[PixsoLtd/pixso-ai-integration](https://github.com/PixsoLtd/pixso-ai-integration)。

## 前置要求

1. 安装 Pixso Desktop。
2. 打开需要操作的 Pixso 文件。
3. 启动 Pixso MCP 服务，默认地址为：

```text
http://localhost:3667/mcp
```

4. 安装并登录 Codex CLI / Codex app。

如果 Pixso MCP 地址不是默认值，请修改 `plugins/pixso/.mcp.json`。

## 从 GitHub 安装

添加插件源并安装 Pixso 插件：

```bash
codex plugin marketplace add PixsoLtd/pixso-ai-integration-codex
codex plugin add pixso@pixso
```

安装后新开一个 Codex thread，再开始使用 Pixso 插件。新 thread 能确保插件能力和 MCP 配置被重新加载。

检查安装结果：

```bash
codex plugin marketplace list
codex plugin list
```

## 从本地 clone 安装

```bash
git clone https://github.com/PixsoLtd/pixso-ai-integration-codex.git
cd pixso-ai-integration-codex
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

1. 先用 CLI 添加插件源：

```bash
codex plugin marketplace add PixsoLtd/pixso-ai-integration-codex
```

2. 打开 Codex app 的 Plugins / Plugin Directory。
3. 找到 `Pixso`。
4. 选择安装。
5. 新开一个 thread 使用插件。

## 配置 Pixso MCP

默认配置会连接：

```text
http://localhost:3667/mcp
```

如果你的 Pixso MCP 运行在其他端口，修改 `plugins/pixso/.mcp.json` 后重新安装或重新加载插件。

检查 MCP 是否可达：

```powershell
.\plugins\pixso\scripts\check_mcp_server.ps1
```

或：

```powershell
Invoke-WebRequest -UseBasicParsing -Method Head -Uri "http://localhost:3667/mcp"
```

## 更新插件

GitHub 安装方式：

```bash
codex plugin marketplace upgrade pixso
codex plugin add pixso@pixso
```

本地 clone 安装方式：

```bash
cd <repo>
git pull
codex plugin add pixso@pixso
```

更新后新开一个 Codex thread。

## 可以怎么用

安装后，可以直接用自然语言让 Codex 调用 Pixso。

### 设计转代码

```text
Use Pixso to convert this selected frame to React code and save all generated assets locally.
```

也可以提供 Pixso URL：

```text
Convert this Pixso URL to Vue code: <Pixso node URL>
```

### 网页或 HTML 导入 Pixso

```text
Import this page into Pixso as editable design nodes: https://example.com
```

如果页面需要登录、权限、区域访问或资源不可抓取，Codex 会先说明阻塞点，不会自动降级成近似重建设计。

### Pixso 设计编辑

```text
Create a dashboard screen in the current Pixso file using the existing design tokens and components.
```

```text
Refine the selected Pixso frame: improve spacing, hierarchy, and visual consistency.
```

### 组件解析配置

使用命令：

```text
/pixso-d2c-plus-config
```

或直接描述需求：

```text
Generate componentParsers for the current Pixso component library and Element Plus.
```

## 常见问题

### 安装后看不到 Pixso plugin

检查插件源和插件是否存在：

```bash
codex plugin marketplace list
codex plugin list
```

如果刚安装或刚更新过插件，请新开一个 Codex thread。

### 看不到 `/pixso-d2c-plus-config`

重新安装插件并新开 thread：

```bash
codex plugin add pixso@pixso
```

### Pixso MCP 不可达

确认 Pixso Desktop 正在运行，目标文件已打开，且 MCP 服务地址与 `plugins/pixso/.mcp.json` 一致。

### 旧的 `pixso-design` 还出现

当前版本使用 `pixso-design-editing`。如果仍看到 `pixso-design`，通常是旧插件缓存或旧 thread：

```bash
codex plugin marketplace upgrade pixso
codex plugin add pixso@pixso
```

然后新开 Codex thread。

## 参考

- [Codex plugins](https://developers.openai.com/codex/plugins)
- [Codex plugin build guide](https://developers.openai.com/codex/plugins/build)
- [Codex CLI plugin commands](https://developers.openai.com/codex/cli/reference)
