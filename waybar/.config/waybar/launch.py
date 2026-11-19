#!/usr/bin/env python3
"""Select Waybar layouts from Niri's logical output sizes, including rotation.

config.jsonc is a JSON template: keep it valid JSON for the standard parser.
Run this launcher instead of waybar to update layouts after output changes.
"""

import json
import os
from pathlib import Path
import signal
import subprocess
import tempfile
import time


def output_layouts(outputs):
    full, compact = [], []
    for name, output in sorted(outputs.items()):
        logical = output.get("logical")
        if logical is None:
            continue
        target = compact if logical["height"] > logical["width"] else full
        target.append(name)
    return full, compact


def read_layouts():
    result = subprocess.run(
        ["niri", "msg", "--json", "outputs"],
        check=True, capture_output=True, text=True, timeout=5,
    )
    return output_layouts(json.loads(result.stdout))


def write_config(template, path, layouts):
    config = json.loads(template.read_text())
    for bar in config:
        bar["output"] = layouts[1] if bar["name"] == "compact" else layouts[0]
    temporary = path.with_suffix(".tmp")
    temporary.write_text(json.dumps(config, ensure_ascii=False, indent=2) + "\n")
    temporary.replace(path)


def stop(_signum, _frame):
    raise SystemExit(0)


def main():
    config_dir = Path(__file__).resolve().parent
    template = config_dir / "config.jsonc"
    signal.signal(signal.SIGTERM, stop)
    signal.signal(signal.SIGINT, stop)
    with tempfile.TemporaryDirectory(
        prefix="waybar-", dir=os.environ.get("XDG_RUNTIME_DIR")
    ) as directory:
        path = Path(directory) / "config.json"
        layouts = read_layouts()
        write_config(template, path, layouts)
        process = subprocess.Popen([
            "waybar", "--config", str(path), "--style", str(config_dir / "style.css")
        ])
        try:
            while process.poll() is None:
                time.sleep(2)
                try:
                    updated = read_layouts()
                except (subprocess.SubprocessError, json.JSONDecodeError):
                    continue
                if updated != layouts:
                    write_config(template, path, updated)
                    if process.poll() is None:
                        process.send_signal(signal.SIGUSR2)
                    layouts = updated
            return process.returncode
        finally:
            if process.poll() is None:
                process.terminate()
                try:
                    process.wait(timeout=5)
                except subprocess.TimeoutExpired:
                    process.kill()
                    process.wait()


if __name__ == "__main__":
    raise SystemExit(main())
