#!/usr/bin/env bash
set -euo pipefail

PLUGIN_ID="vcupid@local"
PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SETTINGS_JSON="$HOME/.claude/settings.json"
INSTALLED_JSON="$HOME/.claude/plugins/installed_plugins.json"
NOW="$(date -u +%Y-%m-%dT%H:%M:%S.000Z)"

# Create .claude-plugin/plugin.json if missing
mkdir -p "$PLUGIN_DIR/.claude-plugin"
if [[ ! -f "$PLUGIN_DIR/.claude-plugin/plugin.json" ]]; then
  cat > "$PLUGIN_DIR/.claude-plugin/plugin.json" <<'EOF'
{
  "name": "VCupid Plugin",
  "description": "AI fundraising toolkit: VC pipeline, fund matching, partner profiling, outreach, and pitch prep"
}
EOF
  echo "Created .claude-plugin/plugin.json"
fi

# Register in installed_plugins.json using Python (no jq dependency)
python3 - "$INSTALLED_JSON" "$PLUGIN_ID" "$PLUGIN_DIR" "$NOW" <<'PYEOF'
import json, sys
path, plugin_id, install_path, now = sys.argv[1:]

with open(path) as f:
    data = json.load(f)

entry = {
    "scope": "user",
    "installPath": install_path,
    "version": "1.0.0",
    "installedAt": now,
    "lastUpdated": now
}

plugins = data.setdefault("plugins", {})
if plugin_id in plugins:
    # Update installPath and lastUpdated, preserve installedAt
    existing = plugins[plugin_id][0]
    existing["installPath"] = install_path
    existing["lastUpdated"] = now
    existing["version"] = "1.0.0"
    print(f"Updated existing entry for {plugin_id}")
else:
    plugins[plugin_id] = [entry]
    print(f"Registered {plugin_id}")

with open(path, "w") as f:
    json.dump(data, f, indent=2)
    f.write("\n")
PYEOF

# Enable in settings.json
python3 - "$SETTINGS_JSON" "$PLUGIN_ID" <<'PYEOF'
import json, sys
path, plugin_id = sys.argv[1:]

with open(path) as f:
    data = json.load(f)

enabled = data.setdefault("enabledPlugins", {})
if enabled.get(plugin_id) is True:
    print(f"{plugin_id} already enabled")
else:
    enabled[plugin_id] = True
    print(f"Enabled {plugin_id} in settings.json")

with open(path, "w") as f:
    json.dump(data, f, indent=2)
    f.write("\n")
PYEOF

# Validate skills if skills-ref is available
if command -v skills-ref &>/dev/null; then
  echo ""
  echo "Validating skills..."
  for skill_dir in "$PLUGIN_DIR/skills/*/"; do
    skills-ref validate "$skill_dir" && echo "  OK: $(basename "$skill_dir")"
  done
fi

echo ""
echo "VCupid Plugin installed. Restart Claude Code to activate the /vc* commands."
