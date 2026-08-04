# AI Instructions

Personal Claude Code configuration, mirroring the layout of a target project:

- `CLAUDE.md` — workflow instructions (how the agent should work), reusable across projects. Imports `AGENTS.md` via `@AGENTS.md`.
- `AGENTS.md` — project-specific instructions (what the project is). Ships as a neutral template — fill it in per project.
- `.claude/agents/` — custom subagents, one `.md` file each (YAML frontmatter + system prompt).

| Agent           | Model  | Purpose                                                                                                                      |
| --------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------- |
| `deep-reasoner` | opus   | Reasoning-heavy phases: architecture, complex debugging, algorithm design. Thinks thoroughly, returns a concise conclusion. |
| `fast-worker`   | sonnet | Mechanical, well-scoped work: boilerplate, tests, formatting, simple edits. Executes directly without deliberation.         |

## Setup

Copy everything into your project root, keeping the relative paths:

```bash
cp -r CLAUDE.md AGENTS.md .claude /path/to/project/
```

All files load automatically at session start; verify agents with `/agents`. To make the subagents available in every project instead, copy them to the user-level directory: `cp .claude/agents/*.md ~/.claude/agents/`.

## Usage

Claude delegates to subagents automatically based on each agent's `description`, or you can ask explicitly:

> Use the deep-reasoner subagent to evaluate these two architecture options.
