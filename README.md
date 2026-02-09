## e-commerce-automation

End-to-end test automation using Robot Framework and Robot Framework Browser (Playwright).


### Prerequisites

- Python 3.11+
- Node.js (includes `npm`/`npx`) installed and available on PATH
- `uv` installed (for example: `pipx install uv` or according to the official documentation)

### Environment setup

1. Clone the repository:

   ```bash
   git clone <REPO_URL>
   cd e-commerce-automation
   ```

2. Create/update the environment with `uv` (recommended):

   ```bash
   uv sync
   ```

3. Initialize Robot Framework Browser (installs Node dependencies and Playwright browsers):

   ```bash
   uv run rfbrowser init
   ```

   This command is important because it:

   - Installs the Node wrapper dependencies under
     `.venv/Lib/site-packages/Browser/wrapper`.
   - Downloads the Playwright browsers and configures the binaries that
     the Browser library uses internally.

   If you skip this step (for example by running `rfbrowser init --skip-browsers`),
   tests may fail with errors like:

   > Executable doesn't exist at ...chrome-headless-shell.exe
   > Please run the following command to download new browsers: npx playwright install

   In that case, just run again:

   ```bash
   uv run rfbrowser init
   ```

### Running the tests

From the project root, run:

```bash
uv run python -m robot -d results tests/playwrightexample.robot
```

This will:

- Create/use the Python environment managed by `uv`.
- Execute Robot Framework using the `Browser` library.
- Store the results in `results/` (`output.xml`, `log.html`, `report.html`).
- Avoid using a globally installed `robot` script that might not see the
  `Browser` package (this is why we prefer `python -m robot` here).

### Common issues

- **Playwright executable missing** (message suggesting `npx playwright install`):
  - Make sure `uv run rfbrowser init` has been executed successfully.

- **Issues with `node.exe` (psutil.AccessDenied) on shutdown**:
  - These are usually warnings and do not prevent test execution.
  - If they start causing failures, kill any orphan `node.exe` processes and
    run `uv run rfbrowser init` again.

