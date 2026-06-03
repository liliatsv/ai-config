# AI Config — Single Source of Truth

This folder is the **source of truth** for all AI tool configurations.
Never edit `.claude/`, `.windsurf/`, or `.github/copilot-instructions.md` directly —
edit here and run `build.sh`.

## Structure

```
ai-config/
├── agents/                  ← one file per agent role (edit these)
│   ├── project-manager.md
│   ├── backend-developer.md
│   ├── db-specialist.md
│   ├── qa.md
│   └── code-reviewer.md
├── rules/
│   └── shared.md            ← rules applied to ALL tools and agents
├── build.sh                 ← generates configs for all tools
└── README.md
```

## Usage

```bash
# From the ai-config directory:
./build.sh /path/to/your/spring-boot-project

# Or from project root (if ai-config is inside the project):
./ai-config/build.sh .
```

## What gets generated

| Tool            | Output location                        | Notes                              |
|-----------------|----------------------------------------|------------------------------------|
| Claude Code     | `.claude/CLAUDE.md`                    | All agents + shared rules          |
| Windsurf        | `.windsurf/rules/`                     | One file per agent                 |
| GitHub Copilot  | `.github/copilot-instructions.md`      | Condensed — Copilot is inline only |

## When to run build.sh

Run it whenever you change any file in `agents/` or `rules/`.
Optionally install as a git pre-commit hook — instructions printed at end of build.sh.

## Prompt Quality Tips

1. **Benchmark tasks**: keep 5–10 tasks with known correct answers. Re-run them after prompt changes.
2. **Evaluator prompt**: paste agent prompt + task + output into a separate Claude chat and ask it to score correctness, completeness, and hallucinations on 1–5.
3. **Proxy metrics to track manually**:
   - Number of correction messages before a usable result
   - Did it touch the right files on the first try? (Y/N)
   - Did you copy-paste the output directly, or rewrite it? 
