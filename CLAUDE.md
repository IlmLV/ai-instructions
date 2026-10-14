# CLAUDE.md

@AGENTS.md

## Planning

- Enter plan mode for architectural decisions or ambiguous asks; for other multi-step work, write a short plan and proceed
- Every plan ends with how the result will be verified
- If something goes sideways, STOP and re-plan immediately

## Subagents

- Offload research, exploration, and analysis to subagents liberally to keep main context clean
- One task per subagent; run independent tasks in parallel
- Route to custom subagents without being asked:
  - `deep-reasoner`: architecture, complex debugging, algorithm design, tradeoff analysis
  - `fast-worker`: boilerplate, tests, formatting, simple or repetitive edits
- Keep orchestration in main context: integrate results, verify, make final decisions

## Verification

- Show evidence before calling work done: run tests, check logs, demonstrate correctness
- Diff behavior between main and your changes when relevant
- The Stop hook runs `.claude/hooks/verify.sh`; make it pass, never bypass it

## Quality

- Fix root causes, not symptoms, and touch nothing beyond that fix
- When merging or refactoring, rewrite for the result rather than stitching parts together
- For non-trivial changes ask "is there a more elegant way?"; if yes, redo it with what you now know. Don't over-engineer simple fixes
- Comments: one line, only for what code can't say; prefer clearer code over a new comment. Deeper context goes in the file header
