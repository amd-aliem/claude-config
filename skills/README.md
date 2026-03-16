# Skills

This directory contains Claude skill definitions — reusable instruction snippets that can be appended to `~/.claude/CLAUDE.md` to give Claude persistent knowledge or behavioral guidelines.

## Structure

Each `.md` file is a self-contained skill that can be selectively installed. Skills are plain markdown and are appended verbatim to your global `CLAUDE.md`.

## Installation

Run `../install.sh` from the repo root to install all skills into `~/.claude/CLAUDE.md`.

To install a single skill manually:

```bash
cat my-skill.md >> ~/.claude/CLAUDE.md
```
