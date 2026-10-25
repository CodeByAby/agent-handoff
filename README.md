# agent-handoff

**Switch Claude Code → Codex → Cursor → Copilot without re-explaining the project.**

Explicit, auditable handoff for multi-agent coding. One shared `AGENTS.md` (rules) + one shared `PROGRESS.md` (status). No extra API key. No chat-history scraping.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/CodeByAby/agent-handoff?style=social)](https://github.com/CodeByAby/agent-handoff/stargazers)

---

## Before / after

```text
WITHOUT handoff                          WITH agent-handoff
─────────────────                        ──────────────────
"Remind me what we decided…"             Agent reads first 30 lines of PROGRESS.md
"Where are the files?"                   Path: /Users/you/proj/deck.pptx
"What failed last time?"                 Failed: tried X; don't retry
Paste the same brief 5 times             Next agent continues from Next:
```

Filled example (what lands in `~/.agents/PROGRESS.md`):

```markdown
## 2026-10-25 10:41｜Codex｜Landing page copy v2
- Goal: Rewrite hero + FAQ for rumpel site
- Decision: Keep CTA "Try free"; drop pricing table from hero
- Constraint: English only; no fake metrics
- Failed: Long FAQ buried CTA (bounced)
- Result: hero.md + faq.md updated
- Path: ~/Sites/rumpel/content/
- Next: 1) Wire into page 2) Check mobile wrap 3) Ship preview URL
```

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


## Features

| Benefit | How |
|---|---|
| Stop re-briefing every tool | Shared `AGENTS.md` + `PROGRESS.md` |
| Cheap context | Next agent reads **only ~30 lines** |
| Auditable | Plain markdown you can diff / review |
| No second bill | Uses your existing Claude / Codex / Cursor / … quota |
| Works beyond one IDE | Adapters + [EXTENDING.md](docs/EXTENDING.md) |

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

## Quick start (after setup)

1. Open any linked agent (Claude Code / Codex / Cursor…).
2. Paste this once (or rely on the linked `AGENTS.md`):

```text
Follow ~/.agents/AGENTS.md. After you finish a stage, prepend a seven-field
handoff to ~/.agents/PROGRESS.md yourself. I should not need to ask you to log progress.
```

3. Give it a tiny real task, e.g. “Create ~/tmp/agent-handoff-demo/hello.txt with one line, then stop.”
4. Open `~/.agents/PROGRESS.md` — you should see Goal / Decision / Constraint / Failed / Result / Path / Next at the top.
5. Switch to another agent and say: **continue the last handoff**.

If step 4 is empty: the agent did not load the rules. Check the adapter table below, or paste the Handoff protocol section from `templates/AGENTS.md` into that tool’s custom instructions.

### Manual install (no script)

```bash
mkdir -p ~/.agents
cp templates/AGENTS.md ~/.agents/AGENTS.md
cp templates/PROGRESS.md ~/.agents/PROGRESS.md
# then hard-link or paste into each tool (see docs/EXTENDING.md)
```

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

## Demo checklist

Same as Quick start. Short form:

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

## Contributing

PRs welcome — especially new adapters (see [docs/EXTENDING.md](docs/EXTENDING.md)).
Open an issue if a tool’s instruction path changed.

## Topics

`agents` `claude-code` `codex` `cursor` `github-copilot` `handoff` `ai-coding` `developer-tools` `vscode` `antigravity`

## License

MIT
