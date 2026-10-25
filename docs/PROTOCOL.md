# Protocol

## Invariants
1. `AGENTS.md` is the only rules source.
2. `PROGRESS.md` is the only daily handoff surface.
3. Newest entry is always at the top (after the header / marker).
4. Read window = first 30 lines unless the user asks for history.
5. No second memory service required.

## Success criteria
- Switch tools without re-briefing in most sessions
- Paths always present in completed handoffs
- No extra API key
- User does not have to say “please write progress”

## Anti-patterns
- Dumping chat transcripts into PROGRESS
- Reading the entire PROGRESS file every turn
- Rewriting AGENTS from an installer without backup
- Mixing personal and work machines into one progress file without isolation
