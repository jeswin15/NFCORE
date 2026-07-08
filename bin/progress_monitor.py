from rich.live import Live
from rich.table import Table
import json
import time

while True:
    table = Table(title="IsoSeqAnnotate Progress")

    table.add_column("Process")
    table.add_column("Status")
    table.add_column("Progress")

    with open("progress.json") as f:
        data = json.load(f)

    for name, pct in data.items():

        if pct == 100:
            status = "✔"
        elif pct == 0:
            status = "Waiting"
        else:
            status = "⏳"

        table.add_row(name, status, f"{pct}%")

    print(table)

    time.sleep(1)