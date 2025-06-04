#!/bin/bash
# git_change_tracker.sh - Because VS Code lies to you

echo "=== ACCURATE FILE CHANGE REPORT ==="
echo "VS Code is probably lying. Here's the truth:"
echo

# Staged files
staged=$(git diff --cached --name-only | wc -l | tr -d ' ')
echo "📁 Staged files: $staged"

# Unstaged changes  
unstaged=$(git diff --name-only | wc -l | tr -d ' ')
echo "📝 Unstaged changes: $unstaged"

# Untracked files
untracked=$(git ls-files --others --exclude-standard | wc -l | tr -d ' ')
echo "❓ Untracked files: $untracked"

# Total actual changes
total=$((staged + unstaged + untracked))
echo "🎯 ACTUAL TOTAL: $total files"

echo
echo "=== DETAILED BREAKDOWN ==="
if [ $staged -gt 0 ]; then
    echo "Staged files:"
    git diff --cached --name-status
    echo
fi

if [ $unstaged -gt 0 ]; then
    echo "Unstaged changes:"  
    git diff --name-status
    echo
fi

if [ $untracked -gt 0 ]; then
    echo "Untracked files:"
    git ls-files --others --exclude-standard
fi
