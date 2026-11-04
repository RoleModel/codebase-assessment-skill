#!/bin/sh
# Builds dist/codebase-assessment-openai-<version>.zip, the package uploaded at
# platform.openai.com/plugins. The zip holds only the manifest, the icons, and the skill;
# evals/ stays out because its sample apps have fake secrets the scanner would flag.
set -eu
cd "$(dirname "$0")/.."

version=$(python3 -c "import json; print(json.load(open('.codex-plugin/plugin.json'))['version'])")
build=dist/openai
out="dist/codebase-assessment-openai-$version.zip"

rm -rf "$build" "$out"
mkdir -p "$build/.codex-plugin" "$build/skills"
cp -R assets "$build/assets"
cp -R codebase-assessment "$build/skills/codebase-assessment"
cp LICENSE "$build/LICENSE"
# In the repo the skill sits at the root; in the zip it sits under skills/.
python3 - "$build/.codex-plugin/plugin.json" <<'PY'
import json, sys
manifest = json.load(open(".codex-plugin/plugin.json"))
manifest["skills"] = "./skills/"
json.dump(manifest, open(sys.argv[1], "w"), indent=2)
PY
find "$build" -name .DS_Store -delete
(cd "$build" && zip -qr "../../$out" .)
echo "$out"
