---
name: review
description: Iterative code review and implementation workflow. Reviews code changes and implements validated improvements until both agents agree code is ready.
allowed-tools: Task, Bash, Read
---

Orchestrates iterative review between reviewer and review-implementor agents until code is approved or max rounds (default: 3) reached.

## When to Use

- After making code changes that need review
- When you want automated review and improvement
- To apply rigorous correctness and clarity standards
- Before committing or creating pull requests

## Iterative Workflow

### Round Loop (Repeat until approved or max rounds)

**Maximum Rounds**: 3 (configurable)

For each round:

#### Step 1: Review Phase

Execute the reviewer agent:

```
Use the Task tool with:
- subagent_type: reviewer
- prompt: "Review the current code changes in round [N]. Focus on correctness, clarity, conventions, and conciseness. Provide specific file:line references for all suggestions."
```

Parse the reviewer's verdict:
- **✅ Approve**: Code is ready, exit loop
- **⚠️ Approve with suggestions**: Has optional improvements
- **❌ Request changes**: Has required fixes

#### Step 2: Check Exit Conditions

Exit the loop if:
- Verdict is **✅ Approve** (code is ready)
- Verdict is **⚠️ Approve with suggestions** AND no changes were implemented in previous round (implementor skipped all suggestions)
- Maximum rounds reached (default: 3)

Otherwise, continue to implementation phase.

#### Step 3: Implementation Phase

Execute the review-implementor agent:

```
Use the Task tool with:
- subagent_type: review-implementor
- prompt: "Round [N] review feedback from the reviewer agent:

[Include the full reviewer output here]

Validate each suggestion and implement the valid ones. Skip invalid suggestions with clear reasoning. Report what was implemented, skipped, and any questions."
```

Track whether any changes were actually implemented.

#### Step 4: Loop Decision

- If changes were implemented: Continue to next round (back to Step 1)
- If no changes were implemented: Exit loop (implementor validated and skipped all suggestions)
- If max rounds reached: Exit loop with summary

### Final Summary

After the loop completes, provide:

```
## Review & Implementation Complete

**Total Rounds**: [N]

**Final Verdict**: [✅/⚠️/❌]

**Total Changes Implemented**: [Count across all rounds]
- [Key changes from each round]

**Total Suggestions Skipped**: [Count across all rounds]
- [Key reasons]

**Exit Reason**:
- [Approved by reviewer / No more valid suggestions / Max rounds reached]

**Next Steps**:
- [What the user should do next]
```

## Round Tracking

Keep track across rounds:
- Round number
- Changes implemented per round
- Suggestions skipped per round
- Cumulative git diff size

After each round, briefly report:
```
Round [N] complete: [X] changes implemented, [Y] suggestions skipped
```

## Important Notes

Iteration stops on approval, no valid suggestions remaining, or max rounds reached.

## Configuration

You can adjust the maximum rounds based on code complexity:
- Simple changes: 1-2 rounds usually sufficient
- Complex refactoring: May need 3 rounds
- Critical code: Consider 3+ rounds for thoroughness

## Usage

Manual invocation:
```
/review
```

The skill will:
1. Review current uncommitted changes (git diff)
2. Implement validated improvements
3. Re-review the updated code
4. Repeat until approved or max rounds reached
5. Report comprehensive results

You can then run `git diff` to see all applied changes.
