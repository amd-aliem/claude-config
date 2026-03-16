# Agents

This directory contains Claude subagent definitions. Each `.md` file defines a specialized agent that can be invoked by Claude Code.

## Structure

Each agent file should follow this format:

```markdown
---
name: agent-name
description: Brief description of when to use this agent
---

You are a specialized assistant for ...

## Your capabilities

- ...
```

## Installation

Run `../install.sh` from the repo root to install all agents to `~/.claude/agents/`.
