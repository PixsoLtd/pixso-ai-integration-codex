# Pixso Plugin

This plugin packages Pixso-driven design workflows for Codex.

It includes skills for:

- using Pixso MCP tools safely and consistently
- translating Pixso designs into production UI code
- generating or updating Pixso designs from code
- editing design nodes, variables, styles, components, and assets
- verifying visual parity after implementation

## Plugin Structure

- `.codex-plugin/plugin.json`
  - required Codex plugin manifest
  - points Codex at the plugin skills and MCP server config

- `.mcp.json`
  - Pixso MCP server configuration
  - expects the local Pixso MCP endpoint at `http://localhost:3667/mcp`

- `skills/`
  - workflow instructions used by Codex agents

- `agents/`
  - focused agent guidance for implementation, visual review, and design system tasks

- `commands/`
  - reusable command prompts for common Pixso workflows

- `scripts/`
  - local validation and helper scripts

- `assets/`
  - plugin icon and logo assets referenced by the manifest

- `ui/`
  - optional workbench surface for future visual debugging

## Notes

This plugin is MCP-backed. Start the Pixso MCP service before using workflows that call Pixso tools.
