## ParaBank Automation (Robot Framework)

End-to-end and API test automation for the ParaBank demo online banking application, built with Robot Framework, Robot Framework Browser (Playwright) and RequestsLibrary.


### Project goals

- Practice modern test automation patterns (page objects, reusable keywords, API helpers).
- Combine **UI** (Browser/Playwright) and **API** (RequestsLibrary) tests against the same system.
- Use **GitHub Actions** + **GitHub Pages** to run tests automatically and publish Robot reports.


### Tech stack

- Python 3.11+
- Robot Framework 7
- Robot Framework Browser (Playwright)
- Robot Framework Requests
- `uv` for dependency and virtualenv management
- GitHub Actions + GitHub Pages for CI and reporting


### Prerequisites

- Python 3.11+ installed
- Node.js (with `npm`/`npx`) on PATH
- `uv` installed (for example: `pipx install uv` or see the official docs)


### Environment setup

1. Clone the repository:

   ```bash
   git clone <REPO_URL>
   cd ParaBank-Automation
   ```

2. Create/update the environment with `uv` (recommended):

   ```bash
   uv sync
   ```

3. Initialize Robot Framework Browser (installs Node dependencies and Playwright browsers):

   ```bash
   uv run rfbrowser init
   ```


### Test suites and tags

Main suites under `tests/`:

- `api_suite.robot` – API tests for customer and account endpoints
- `functional_negative_suite.robot` – UI registration/login (happy path + negative)
- `e2e_suite.robot` – end-to-end UI flows (open account, transfer funds)

Useful tags (can be combined):

- Layer: `api`, `ui`, `e2e`
- Type: `smoke`, `regression`, `negative`, `boundary`, `known-issue`
- Feature: `login`, `register`, `customer`, `accounts`, `transfer`

Examples:

```bash
# All tests
uv run python -m robot -d results tests/

# Only API smoke tests
uv run python -m robot -d results --include api --include smoke tests/

# Only UI login tests
uv run python -m robot -d results --include ui --include login tests/

# Regression suite excluding known issues
uv run python -m robot -d results --include regression --exclude known-issue tests/
```


### CI/CD and reports

- GitHub Actions workflow at `.github/workflows/ci.yml`:
  - Installs dependencies with `uv sync`.
  - Initializes Robot Framework Browser (`uv run rfbrowser init`).
  - Runs all Robot suites: `uv run python -m robot -d results tests/`.
  - Uploads `results/` as an artifact.
  - Publishes the same `results/` folder to GitHub Pages.
- Each run adds direct links to `log.html` and `report.html` in the Actions **Summary**.


### Common issues

- **Playwright executable missing** (message suggesting `npx playwright install`):
  - Make sure `uv run rfbrowser init` has been executed successfully.

- **Linux browser dependencies missing in CI**:
  - The workflow installs them using `npx playwright install-deps`.

- **Issues with `node.exe` on Windows shutdown**:
  - Usually warnings only; kill orphan `node.exe` processes if needed and re-run `uv run rfbrowser init`.

