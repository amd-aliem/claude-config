# Claude Code Configuration

A portable repository for Claude Code skills, agents, and settings that can be easily installed on any system.

## Quick Install

Clone this repository and run:

```bash
./install.sh
```

This will copy all skills and agents to `~/.claude/` making them available in all your projects.

## Structure

```
claude-config/
├── skills/           # Portable skills
│   └── <skill-name>/
│       └── SKILL.md
├── agents/           # Portable agents
│   └── <agent-name>/
│       └── SKILL.md
├── settings.json     # User-level settings (optional)
├── install.sh        # Installation script
└── README.md         # This file
```

## Adding New Skills

Create a new skill directory:

```bash
mkdir -p skills/my-skill
cat > skills/my-skill/SKILL.md << 'EOF'
---
name: my-skill
description: When to use this skill
---

Instructions for Claude here.
EOF
```

Then commit and push:

```bash
git add skills/my-skill
git commit -m "Add my-skill"
git push
```

## Adding New Agents

Create a new agent directory:

```bash
mkdir -p agents/my-agent
cat > agents/my-agent/SKILL.md << 'EOF'
---
name: my-agent
description: When to delegate to this agent
tools: Read, Grep, Bash
model: sonnet
---

System prompt for the agent here.
EOF
```

Then commit and push:

```bash
git add agents/my-agent
git commit -m "Add my-agent"
git push
```

## Installing on a New System

1. Clone this repository:
   ```bash
   git clone <your-repo-url> ~/claude-config
   cd ~/claude-config
   ```

2. Run the installer:
   ```bash
   ./install.sh
   ```

3. Start using Claude Code with your skills and agents.

## Updating

When you add new skills or agents, pull the latest changes and re-run the installer:

```bash
cd ~/claude-config
git pull
./install.sh
```

## Removing Skills and Agents

To remove a skill or agent from your system:

```bash
# Remove a skill
rm -rf ~/.claude/skills/<skill-name>

# Remove an agent
rm -rf ~/.claude/agents/<agent-name>
```

To clean up backup files created by the installer:

```bash
# Remove all backup files
rm -rf ~/.claude/skills/*.backup
rm -rf ~/.claude/agents/*.backup
rm ~/.claude/settings.json.backup
```

## User Settings

The optional `settings.json` file contains user-level preferences.

Example `settings.json`:

```json
{
  "model": "Claude-Opus-4.6",
  "permissions": {
    "allow": [
      "Bash(git *)",
      "Bash(npm *)"
    ]
  }
}
```

Note: The installer backs up your existing settings before overwriting.

## Tips

- **Skills** are invoked with `/skill-name` or loaded automatically when Claude's task matches the skill description
- **Agents** are specialized subagents that Claude delegates work to via the Task tool
- Skills and agents in `~/.claude/` are available across all projects
- Project-specific configurations should go in `.claude/` within each project
