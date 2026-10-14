# AI Instructions

Personal Claude Code configuration, mirroring the layout of a target project:

- `CLAUDE.md` — short workflow guidance (how the agent should work), reusable across projects. Imports `AGENTS.md` via `@AGENTS.md`. Kept deliberately brief: current guidance for the Claude 5 family is that long prescriptive rule lists degrade output — hard rules belong in hooks, not prose.
- `AGENTS.md` — project-specific instructions (what the project is). Ships as a neutral template — fill it in per project.
- `.claude/settings.json` — shared project settings: a starter allowlist of read-only commands, deny rules for secrets, and a Stop hook wired to `verify.sh`. Extend the allowlist from real usage with `/fewer-permission-prompts`.
- `.claude/hooks/verify.sh` — Stop-hook verification gate. Fill in the project's test/lint commands; exit code 2 blocks Claude from finishing until checks pass. Skips when the working tree is clean and never blocks twice in a row, so it can't loop.
- `.claude/rules/` — path-scoped rules (loaded only when Claude touches matching files). Ships with a `tests.md` example.
- `.claude/agents/` — custom subagents, one `.md` file each (YAML frontmatter + system prompt). Both persist cross-session notes via `memory: local` — per-project agent memory that stays on your machine, outside git, so there are no memory files to maintain in the repo.

| Agent           | Model                 | Purpose                                                                                                                     |
| --------------- | --------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `deep-reasoner` | inherit (inherits effort) | Reasoning-heavy phases: architecture, complex debugging, algorithm design. Thinks thoroughly, returns a concise conclusion. |
| `fast-worker`   | sonnet (medium effort) | Mechanical, well-scoped work: boilerplate, tests, formatting, simple edits. Executes directly without deliberation.         |

Lesson-capturing is handled by Claude Code's built-in auto memory (on by default) rather than hand-maintained files, and task tracking by the built-in task list — so there is no `tasks/` convention here.

## Setup

Copy everything into your project root, keeping the relative paths:

```bash
cp -r CLAUDE.md AGENTS.md .claude /path/to/project/
```

Then fill in `AGENTS.md` and put the project's real checks into `.claude/hooks/verify.sh`. All files load automatically at session start; project permission rules and frontmatter hooks take effect after you accept the workspace trust dialog. Verify with `/context` (memory files) and `/status`. To make the subagents available in every project instead, copy them to the user-level directory: `cp .claude/agents/*.md ~/.claude/agents/`.

## Usage

Claude delegates to subagents automatically based on each agent's `description`, or you can ask explicitly:

> Use the deep-reasoner subagent to evaluate these two architecture options.
