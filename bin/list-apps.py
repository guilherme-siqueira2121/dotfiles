#!/usr/bin/env python3
import os
import json
import configparser
import glob

dirs = [
    "/usr/share/applications",
    os.path.expanduser("~/.local/share/applications"),
]

apps = {}

for d in dirs:
    for path in glob.glob(os.path.join(d, "*.desktop")):
        cp = configparser.RawConfigParser(strict=False)
        try:
            cp.read(path, encoding="utf-8")
        except Exception:
            continue

        if not cp.has_section("Desktop Entry"):
            continue

        entry = cp["Desktop Entry"]

        if entry.get("NoDisplay", "false").lower() == "true":
            continue
        if entry.get("Hidden", "false").lower() == "true":
            continue
        if entry.get("Type", "") != "Application":
            continue

        name = entry.get("Name", "").strip()
        if not name:
            continue

        exec_cmd = entry.get("Exec", "").strip()
        for code in ["%u", "%U", "%f", "%F", "%i", "%c", "%k", "%d", "%D", "%n", "%N", "%v", "%m"]:
            exec_cmd = exec_cmd.replace(code, "")
        exec_cmd = exec_cmd.strip()

        comment = entry.get("Comment", "").strip()
        icon = entry.get("Icon", "").strip()

        apps[name] = {
            "name": name,
            "exec": exec_cmd,
            "comment": comment,
            "icon": icon,
        }

results = sorted(apps.values(), key=lambda x: x["name"].lower())
print(json.dumps(results, ensure_ascii=False))