param(
  [string]$PluginRoot = (Split-Path -Parent $PSScriptRoot)
)

$manifest = Join-Path $PluginRoot '.codex-plugin\plugin.json'
$mcp = Join-Path $PluginRoot '.mcp.json'
$skills = Join-Path $PluginRoot 'skills'

if (!(Test-Path $manifest)) { throw "Missing manifest: $manifest" }
if (!(Test-Path $mcp)) { throw "Missing MCP config: $mcp" }
if (!(Test-Path $skills)) { throw "Missing skills directory: $skills" }

Write-Output "Pixso plugin structure looks valid: $PluginRoot"
