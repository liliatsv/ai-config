# AI Config — Single Source of Truth

All AI tool configurations live here. Never edit the generated files directly.

## Structure

```
ai-config/
├── agents/                  ← EDIT THESE (one file per agent role)
│   ├── project-manager.md
│   ├── backend-developer.md
│   ├── db-specialist.md
│   ├── qa-engineer.md
│   └── code-reviewer.md
│
├── tools/                   ← Tool-specific headers/wrappers
│   ├── claude\wrapper.md    ← Claude Code preamble
│   ├── windsurf\wrapper.md  ← Windsurf Cascade preamble
│   └── copilot\wrapper.md   ← GitHub Copilot preamble
│
├── eval/                    ← Testing your prompt quality
│   ├── evaluator-prompt.md  ← Paste into Claude to score an agent
│   └── benchmark-tasks.md   ← Known tasks to run agents against
│
├── build.ps1                ← Run this after any edit
└── README.md                ← This file
```

## How to Use

### Make a change
1. Edit any file in `agents\`
2. Run `.\build.ps1`
3. Done — all three tools are updated

### Change where your project is
```powershell
.\build.ps1 -ProjectRoot "C:\path\to\your\springboot-project"
```

### First-time setup (if PowerShell blocks scripts)
```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

### Test prompt quality
1. Open `eval\benchmark-tasks.md` — pick a task
2. Run it against the relevant agent in your tool of choice
3. Open `eval\evaluator-prompt.md` — paste into a fresh Claude chat with the output
4. Improve the agent file based on the feedback
5. Re-run `.\build.ps1`

## Generated files (do not edit manually)
- `.claude\CLAUDE.md`
- `.windsurf\rules\*.md`
- `.github\copilot-instructions.md`
