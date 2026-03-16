#!/bin/bash
set -e

# Claude Code Configuration Installer
# This script installs all skills and agents to your user-level Claude directory

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${HOME}/.claude"

echo "🤖 Installing Claude Code skills and agents..."

# Create user-level directories if they don't exist
mkdir -p "${CLAUDE_DIR}"/{skills,agents}

# Install skills
if [ -d "${SCRIPT_DIR}/skills" ]; then
    echo "📦 Installing skills..."
    shopt -s nullglob
    skills_found=0
    for skill in "${SCRIPT_DIR}/skills"/*; do
        if [ -d "$skill" ]; then
            skills_found=1
            skill_name=$(basename "$skill")
            echo "  - Installing skill: $skill_name"

            # Backup existing skill if present
            if [ -d "${CLAUDE_DIR}/skills/${skill_name}" ]; then
                echo "    (backing up existing to ${skill_name}.backup)"
                rm -rf "${CLAUDE_DIR}/skills/${skill_name}.backup"
                mv "${CLAUDE_DIR}/skills/${skill_name}" "${CLAUDE_DIR}/skills/${skill_name}.backup"
            fi

            # Copy skill to user directory
            cp -r "$skill" "${CLAUDE_DIR}/skills/${skill_name}"
        fi
    done
    shopt -u nullglob
    if [ $skills_found -eq 0 ]; then
        echo "  - No skills found"
    fi
fi

# Install agents
if [ -d "${SCRIPT_DIR}/agents" ]; then
    echo "🤖 Installing agents..."
    shopt -s nullglob
    agents_found=0
    for agent in "${SCRIPT_DIR}/agents"/*; do
        if [ -d "$agent" ]; then
            agents_found=1
            agent_name=$(basename "$agent")
            echo "  - Installing agent: $agent_name"

            # Backup existing agent if present
            if [ -d "${CLAUDE_DIR}/agents/${agent_name}" ]; then
                echo "    (backing up existing to ${agent_name}.backup)"
                rm -rf "${CLAUDE_DIR}/agents/${agent_name}.backup"
                mv "${CLAUDE_DIR}/agents/${agent_name}" "${CLAUDE_DIR}/agents/${agent_name}.backup"
            fi

            # Copy agent to user directory
            cp -r "$agent" "${CLAUDE_DIR}/agents/${agent_name}"
        fi
    done
    shopt -u nullglob
    if [ $agents_found -eq 0 ]; then
        echo "  - No agents found"
    fi
fi

# Copy user settings if present (backup existing)
if [ -f "${SCRIPT_DIR}/settings.json" ]; then
    echo "⚙️  Installing user settings..."
    if [ -f "${CLAUDE_DIR}/settings.json" ]; then
        echo "  - Backing up existing settings to settings.json.backup"
        cp "${CLAUDE_DIR}/settings.json" "${CLAUDE_DIR}/settings.json.backup"
    fi
    cp "${SCRIPT_DIR}/settings.json" "${CLAUDE_DIR}/settings.json"
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "Installed to: ${CLAUDE_DIR}"
echo ""
echo "Your skills and agents are now available in all Claude Code sessions."
echo "Invoke skills with /skill-name in any Claude Code session."
