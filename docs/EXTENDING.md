# Extending to other agents & IDEs

Your setup is compatible with anything that can follow markdown instructions.

## Checklist for a new tool

1. Find how the tool loads “project rules / custom instructions / AGENTS”.
2. Point that entry at the **same** `~/.agents/AGENTS.md` (hard-link, symlink, or one-time paste).
3. Ensure the tool is allowed to write `~/.agents/PROGRESS.md` (or document a manual paste fallback).
4. Add the tool’s display name to the ToolName list in AGENTS.
5. Run the 5-minute acceptance test in the README.

## Popular adapters

### GitHub Copilot (VS Code / Xcode / JetBrains)
- Create `.github/copilot-instructions.md` as a hard-link or short file that says: follow `~/.agents/AGENTS.md` and the seven-field PROGRESS protocol.
- In VS Code: enable Copilot Chat workspace instructions if available.
- In Xcode: use Copilot for Xcode custom instructions with the same text, or keep `AGENTS.md` at repo root for human+agent reading.

### VS Code (without Copilot)
- Use a workspace `.vscode/` note or an extension that supports rule files (Continue, Cline, etc.).
- Worst case: paste the handoff section of AGENTS into the chat system prompt once per workspace.

### JetBrains AI
- Project AI guidelines / `.aiassistant` / markdown guidelines: link or embed the handoff section.
- Keep writing PROGRESS to the shared path so CLI agents can continue.

### Windsurf
- `.windsurfrules` → hard-link or include “read/write ~/.agents/PROGRESS.md per protocol”.

### Cline
- `.clinerules` → same.

### Aider
- Point `.aider.conf.yml` `read` list at `AGENTS.md`, and remind in the message to update PROGRESS on finish.
- Or wrap a shell alias that prints the latest PROGRESS head before `aider`.

### OpenCode
- Native `AGENTS.md` support — hard-link from `~/.agents/AGENTS.md`.

### Google Antigravity
- Put a short custom instruction: obey shared AGENTS + seven-field PROGRESS.
- Prefer a repo-root `AGENTS.md` hard-link for portability.

### Warp / Amazon Q / Replit Agent / Devin / others
- If the product only has a “custom instructions” text box, paste the **Handoff protocol** section.
- Still keep artifacts + PROGRESS on disk so local agents can resume offline.

## Isolation tip
Use separate `~/.agents-work/` vs `~/.agents-personal/` (or machine-separate hubs) if you must keep work and personal progress from mixing.

## Contributing an adapter
Open a PR that adds:
- detection paths in `scripts/setup.sh` / `setup.ps1`
- 5 lines in this doc
- a sample snippet under `templates/adapters/` (optional)
