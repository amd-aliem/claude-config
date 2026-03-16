#!/usr/bin/env bash
# install.sh — Install Claude skills and agents from this repository.
#
# Usage:
#   ./install.sh            # Install everything (agents + skills)
#   ./install.sh agents     # Install agents only
#   ./install.sh skills     # Install skills only
#
# Agents are copied to ~/.claude/agents/
# Skills are appended to ~/.claude/CLAUDE.md (deduplicated by heading)

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${HOME}/.claude"
AGENTS_DIR="${CLAUDE_DIR}/agents"
CLAUDE_MD="${CLAUDE_DIR}/CLAUDE.md"

MODE="${1:-all}"

install_agents() {
    echo "Installing agents → ${AGENTS_DIR}/"
    mkdir -p "${AGENTS_DIR}"

    local count=0
    for src in "${REPO_DIR}/agents/"*.md; do
        [[ -e "${src}" ]] || continue
        [[ "$(basename "${src}")" == "README.md" ]] && continue
        local dest="${AGENTS_DIR}/$(basename "${src}")"
        cp "${src}" "${dest}"
        echo "  ✓ $(basename "${src}")"
        (( count++ )) || true
    done

    if (( count == 0 )); then
        echo "  (no agent files found)"
    else
        echo "  ${count} agent(s) installed."
    fi
}

install_skills() {
    echo "Installing skills → ${CLAUDE_MD}"
    mkdir -p "${CLAUDE_DIR}"
    touch "${CLAUDE_MD}"

    local count=0
    for src in "${REPO_DIR}/skills/"*.md; do
        [[ -e "${src}" ]] || continue
        [[ "$(basename "${src}")" == "README.md" ]] && continue

        # Determine the first heading in the skill file to use as a dedup key
        local heading
        heading="$(grep -m1 '^#' "${src}" || echo "")"

        if [[ -n "${heading}" ]] && grep -qF "${heading}" "${CLAUDE_MD}" 2>/dev/null; then
            echo "  ~ $(basename "${src}") already present (skipped)"
            continue
        fi

        # Append a blank line separator then the skill content
        echo "" >> "${CLAUDE_MD}"
        cat "${src}" >> "${CLAUDE_MD}"
        echo "  ✓ $(basename "${src}")"
        (( count++ )) || true
    done

    if (( count == 0 )); then
        echo "  (no new skills to install)"
    else
        echo "  ${count} skill(s) appended to ${CLAUDE_MD}."
    fi
}

case "${MODE}" in
    agents)
        install_agents
        ;;
    skills)
        install_skills
        ;;
    all)
        install_agents
        install_skills
        ;;
    *)
        echo "Usage: $0 [all|agents|skills]" >&2
        exit 1
        ;;
esac

echo "Done."
