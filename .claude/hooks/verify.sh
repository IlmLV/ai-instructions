#!/usr/bin/env bash
# Stop hook: runs the project's checks before Claude ends its turn.
#
# Exit codes:
#   0 — allow the turn to end
#   2 — block; anything written to stderr is fed back to Claude to act on
#
# Claude Code passes hook context as JSON on stdin.

input=$(cat)

# Loop guard. When Claude continues because this hook blocked it, Claude Code
# sets "stop_hook_active": true. Let that second pass through, otherwise a
# persistently failing check would re-trigger the hook forever.
if echo "$input" | grep -q '"stop_hook_active": *true'; then
  exit 0
fi

# Nothing changed in the working tree (e.g. a pure Q&A turn): nothing to verify.
if [ -z "$(git status --porcelain 2>/dev/null)" ]; then
  exit 0
fi

# ---------------------------------------------------------------------------
# Project checks. Uncomment and adapt. Keep output short: Claude only needs
# the failing part, not the whole log.
# ---------------------------------------------------------------------------

# if ! npm test --silent >/tmp/claude-verify.log 2>&1; then
#   tail -30 /tmp/claude-verify.log >&2
#   echo "Tests are failing — fix them before finishing." >&2
#   exit 2
# fi

exit 0
