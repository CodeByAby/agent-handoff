# Global AI work rules (shared across coding agents)

> Single source of truth. Path suggestion: `~/.agents/AGENTS.md`
> Hard-link or copy this into each tool’s instruction entry point.
> On every new task or cross-tool handoff, read `~/.agents/PROGRESS.md` **first 30 lines only**.

## Who I am
- Describe yourself in 2–4 bullets (role, language preference, default stack).

## Shared paths
- Agents hub: `~/.agents/`
- Skills (optional): `~/.agents/skills/`
- Projects: put real project roots here

## Handoff protocol (required)

### On start (read)
1. Read `~/.agents/PROGRESS.md` **first 30 lines only** (newest entries).
2. For vague requests (“continue that”, “keep going on the deck”), use the latest entry’s **Path** + **Next**. Do not ask where the files are if Path is present.
3. Absorb only Goal / Decision / Constraint / Failed that are relevant to *this* turn.

### On finish (write) — user should not need to prompt
After any meaningful stage (research done, outline done, code/docs changed):
1. Save artifacts into the project folder with clear names.
2. **Prepend** a seven-field entry to the top of `PROGRESS.md` (newest first).

Entry format (all seven fields required; use `none` if empty):

```markdown
## YYYY-MM-DD HH:mm｜ToolName｜One-line title
- Goal: …
- Decision: …
- Constraint: …
- Failed: …   # method-level only; no blame
- Result: …
- Path: /absolute/path or URL
- Next: 1–3 executable steps for the next agent
```

ToolName examples: `Claude Code` / `Codex` / `Cursor` / `Copilot` / `Windsurf` / `Cline` / `Aider` / `OpenCode` / `JetBrains AI` / `Antigravity` / your name.

### Optional long-running project file
For multi-day / multi-tool work (>~3 stages), keep `PROJECT_HANDOFF.md` in the project root with four living sections: Goal, Decisions, Constraints, Failed list. Stage slices still go to `PROGRESS.md`.

## Safety
- Ask before delete / send / pay / deploy unless the user already authorized that action.
- Never put secrets (API keys, tokens) into chat or into PROGRESS.md.
- Do not install third-party hooks that rewrite this file without an explicit backup + user OK.

## Style
- Lead with the answer; short sentences; match the user’s language.
