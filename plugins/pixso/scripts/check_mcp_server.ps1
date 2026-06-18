param(
  [string]$Url = 'http://localhost:3667/mcp'
)

try {
  $response = Invoke-WebRequest -UseBasicParsing -Method Head -Uri $Url -TimeoutSec 3
  Write-Output "Pixso MCP endpoint responded with status $($response.StatusCode): $Url"
} catch {
  Write-Output "Pixso MCP endpoint is not reachable: $Url"
  exit 1
}
