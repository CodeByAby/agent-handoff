# agent-handoff

**Switch Claude Code → Codex → Cursor → Copilot without re-explaining the project.**

Explicit, auditable handoff for multi-agent coding. One shared `AGENTS.md` (rules) + one shared `PROGRESS.md` (status). No extra API key. No chat-history scraping.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

---

## Why this exists

You use more than one coding agent. Each switch usually means re-stating:

- what you are building
- decisions already made
- hard constraints
- failed attempts
- where the files are
- what to do next

**agent-handoff** makes the *current* agent write a short seven-field handoff at the top of `PROGRESS.md`, and the *next* agent read only the latest entries (first ~30 lines). Token cost stays small and predictable.

## 30-second idea

```text
~/.agents/AGENTS.md     ← single source of rules (hard-linked into each tool)
~/.agents/PROGRESS.md   ← append-only handoff log (newest at top)
```

On finish, the agent **must** prepend:

```markdown
## YYYY-MM-DD HH:mm｜Tool｜One-line title
- Goal: …
- Decision: …   (or "none")
- Constraint: … (or "none")
- Failed: …     (or "none")
- Result: …
- Path: /absolute/or/url
- Next: 1–3 concrete steps
```

On start / “continue that thing”, the agent reads **only the first 30 lines**.

## Install (macOS / Linux)

```bash
git clone https://github.com/CodeByAby/agent-handoff.git
cd agent-handoff
./scripts/setup.sh
```

Windows (PowerShell):

```powershell
.\scripts\setup.ps1
```

What setup does:

1. Creates `~/.agents/`
2. Copies templates if missing
3. Hard-links / copies into popular tool entry points (see below)
4. Prints a verification checklist

> Never commit your real `PROGRESS.md` history. The repo only ships templates.

## Built-in adapters (popular tools)

| Tool | How it loads rules | Status in this repo |
|---|---|---|
| **Claude Code** | `~/.claude/CLAUDE.md` hard-link | ✅ |
| **OpenAI Codex** | `~/.codex/AGENTS.md` hard-link | ✅ |
| **Cursor** | project/`AGENTS.md` or User Rules paste | ✅ |
| **GitHub Copilot** (VS Code / Xcode / JetBrains) | `.github/copilot-instructions.md` | ✅ |
| **OpenCode** | `AGENTS.md` | ✅ |
| **Windsurf** | `.windsurfrules` | ✅ |
| **Cline** | `.clinerules` | ✅ |
| **Aider** | `.aider.conf.yml` + convention | ✅ |
| **Continue** | `.continue/rules` snippet | ✅ |
| **JetBrains AI** | project AI guidelines pointer | ✅ docs |
| **Google Antigravity** | custom instructions pointer | ✅ docs |
| **VS Code** (generic) | workspace instructions / Copilot | ✅ docs |
| **Xcode** | Copilot for Xcode instructions / repo `AGENTS.md` | ✅ docs |
| **Warp / Amazon Q / others** | bring-your-own adapter | ✅ extension guide |

Your personal tools (WorkBuddy, Grok Bot, …) work the same way: point them at the same two files.

## Extend to any agent (VS Code, Xcode, …)

Yes — this design is **intentionally compatible**.

Minimum bar for a new tool:

1. **Can read** a markdown rules file (or you paste the same text into its instruction box once).
2. **Can write** (or you allow it to write) the shared `PROGRESS.md`.
3. You add 5–10 lines telling it: *read first 30 lines on start; prepend seven fields on finish*.

See [docs/EXTENDING.md](docs/EXTENDING.md) for a checklist and examples for VS Code, Xcode, JetBrains, Windsurf, Cline, Aider, Copilot, Antigravity.

PRs that add adapters are welcome. Prefer hard-links or sync scripts over rewriting the user’s `AGENTS.md` body.

## What this is / is not

| Is | Is not |
|---|---|
| Explicit handoff protocol | Automatic chat-history memory DB |
| Works with your existing model subscriptions | A product that needs a second API key |
| Auditable markdown you can diff | Silent context injection you cannot review |
| Multi-tool + multi-IDE | A replacement for one mega-agent |

## Star-friendly demo flow

1. `./scripts/setup.sh`
2. Ask Claude Code to do a tiny task and stop
3. Confirm a seven-field block appears at the top of `~/.agents/PROGRESS.md`
4. Open Codex / Cursor and say: **“continue the last handoff”**
5. It should locate the path + next steps without you re-briefing

## Repo layout

```text
templates/AGENTS.md          # clean public rules template
templates/PROGRESS.md        # empty progress log + format
docs/EXTENDING.md            # add VS Code / Xcode / any agent
docs/PROTOCOL.md             # read/write contract
scripts/setup.sh             # macOS/Linux
scripts/setup.ps1            # Windows
LICENSE
```

## Topics

`agents` `claude-code` `codex` `cursor` `github-copilot` `vscode` `xcode` `handoff` `ai-coding` `developer-tools`

## License

MIT
