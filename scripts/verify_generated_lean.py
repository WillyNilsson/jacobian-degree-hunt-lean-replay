#!/usr/bin/env python3
from __future__ import annotations
import hashlib
import json
import subprocess
import sys
from pathlib import Path

root = Path(__file__).resolve().parents[1]
artifacts = root.parent / "evidence" / "public_ci_certificate_artifacts"
if not artifacts.exists():
    artifacts = root / "evidence" / "public_ci_certificate_artifacts"

subprocess.run([
    sys.executable, str(root / "scripts" / "extract_and_generate_lean.py"),
    str(artifacts), str(root / ".verification")
], check=True)

for source in sorted((root / "LeanFormalization" / "Certificates").glob("*.lean")):
    regenerated = root / ".verification" / "LeanFormalization" / "Certificates" / source.name
    if source.read_bytes() != regenerated.read_bytes():
        raise SystemExit(f"generated file drift: {source}")
    if b"sorry" in source.read_bytes() or b"axiom " in source.read_bytes():
        raise SystemExit(f"forbidden placeholder in generated certificate: {source}")

manifest = json.loads((root / "certificate_data" / "manifest.json").read_text())
print(f"verified {len(manifest['cases'])} generated certificate modules")
for item in manifest["cases"]:
    print(item["slug"], item["canonical_system_sha256"], item["global_denominator"])
