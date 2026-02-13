# ParaBank Test Automation

End-to-end and API test automation for the [ParaBank](https://parabank.parasoft.com/parabank/) demo banking application, built with **Robot Framework**, **Browser Library (Playwright)** and **RequestsLibrary**.

> **Learning project** — showcases modern test automation patterns including Page Object Model, randomized test data generation, API + UI validation, and CI/CD with GitHub Actions.

---

## Architecture

```
ParaBank-Automation/
├── tests/                          # Test suites
│   ├── api_suite.robot             #   API tests (REST endpoints)
│   ├── e2e_suite.robot             #   End-to-end UI flows
│   └── functional_negative_suite.robot  #   Login/register + negative cases
├── resources/                      # Reusable keywords & config
│   ├── variables.resource          #   Centralized global variables
│   ├── common.resource             #   Shared keywords, setups, data generation
│   ├── api.resource                #   API helper keywords
│   └── pages/                      #   Page Object Model
│       ├── home_page.resource      #       Home page (browser, navigation)
│       ├── login_sign_up.resource  #       Login & registration page
│       └── account_page.resource   #       Account management pages
├── libraries/
│   └── faker.py                    #   Custom data generation library
├── .github/workflows/
│   └── ci.yml                      #   GitHub Actions CI pipeline
├── pyproject.toml                  #   Python project & dependencies (uv)
└── results/                        #   Test output (gitignored)
```

---

## Tech stack

| Tool | Purpose |
|------|---------|
| **Python 3.11+** | Runtime |
| **Robot Framework 7** | Test framework |
| **Browser Library** (Playwright) | UI automation |
| **RequestsLibrary** | API testing |
| **uv** | Dependency & virtualenv management |
| **GitHub Actions** | CI/CD pipeline |
| **GitHub Pages** | Published test reports |

---

## Getting started

### Prerequisites

- Python 3.11+
- Node.js 18+ (for Playwright)
- [uv](https://docs.astral.sh/uv/) (`pipx install uv`)

### Setup

```bash
git clone <REPO_URL>
cd ParaBank-Automation

# Install Python dependencies
uv sync

# Install Playwright browsers
uv run rfbrowser init
```

### Running tests

```bash
# All tests
uv run python -m robot -d results tests/

# Only API smoke tests
uv run python -m robot -d results --include api --include smoke tests/

# Only UI login tests
uv run python -m robot -d results --include ui --include login tests/

# Regression tests
uv run python -m robot -d results --include regression tests/

# Dry-run (validate syntax without executing)
uv run python -m robot --dryrun -d results tests/
```

---

## Test suites

| Suite | Layer | Tests | Description |
|-------|-------|-------|-------------|
| `functional_negative_suite` | UI | 3 | User registration, login (valid + invalid credentials) |
| `e2e_suite` | UI + API | 3 | Open account, transfer funds, verify account via API |
| `api_suite` | API | 5 | Customer & account endpoints (CRUD + negative cases) |

### Tags

| Category | Tags |
|----------|------|
| **Layer** | `api`, `ui`, `e2e` |
| **Type** | `smoke`, `regression`, `negative`, `boundary` |
| **Feature** | `login`, `register`, `customer`, `accounts`, `transfer` |

---

## Key patterns demonstrated

- **Page Object Model (POM)** — locators and UI keywords isolated in `resources/pages/`, never in test files
- **Centralized variables** — single `variables.resource` for all global config and constants
- **Randomized test data** — custom `faker.py` library and modular keywords generate unique user data per run, avoiding test coupling
- **API + UI validation** — e2e tests combine browser actions with REST API assertions
- **Clean test isolation** — database reset via API before each suite; `Suite Setup` / `Test Teardown` hooks
- **Single import entry point** — test files import only `common.resource`, which transitively provides everything
- **Flexible, reusable keywords** — API keywords accept optional arguments (e.g., expected status), allowing use in both positive and negative scenarios without duplication
- **Generalized data handling** — keywords return all generated data, and each test uses only the necessary fields, making reuse easy and safe

---

## CI/CD

The GitHub Actions pipeline (`.github/workflows/ci.yml`):

1. Runs on every push/PR to `main` + daily schedule (cron)
2. Installs Python, Node.js, dependencies, and Playwright browsers
3. Executes all Robot Framework suites
4. Uploads test artifacts (`results/`)
5. Publishes `log.html` and `report.html` to **GitHub Pages**

---

## Common issues

| Problem | Solution |
|---------|----------|
| Playwright executable missing | Run `uv run rfbrowser init` |
| Linux browser deps missing in CI | Handled by `npx playwright install-deps` in workflow |
| `node.exe` warnings on Windows | Kill orphan processes and re-run `uv run rfbrowser init` |

