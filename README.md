# claude-config

A repository for storing and easily installing [Claude Code](https://docs.anthropic.com/en/docs/claude-code) skills and agents across systems.

## Repository layout

```
agents/        # Subagent definitions (.md files with front-matter)
skills/        # Reusable instruction snippets appended to CLAUDE.md
install.sh     # One-command installer
```

## Quick start

```bash
git clone https://github.com/amd-aliem/claude-config.git
cd claude-config
./install.sh
```

This installs:
- **Agents** → `~/.claude/agents/` (each `.md` file becomes an available subagent in Claude Code)
- **Skills** → appended to `~/.claude/CLAUDE.md` (persistent instructions Claude always follows)

### Selective install

```bash
./install.sh agents   # agents only
./install.sh skills   # skills only
```

## Adding your own agents

Create a new `.md` file in `agents/` with the following front-matter:

```markdown
---
name: my-agent
description: One-line description of when Claude should use this agent.
---

You are a specialist in ...
```

See the [agents/](agents/) directory for examples.

## Adding your own skills

Create a new `.md` file in `skills/` containing the instructions you want Claude to always follow. Start with a `##` heading — the installer uses it to detect duplicates and avoid appending the same skill twice.

See the [skills/](skills/) directory for examples.
