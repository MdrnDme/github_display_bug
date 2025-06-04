#!/bin/bash
# install.sh - Install VS Code Display Bug Tools

echo "🛠️  Installing VS Code Display Bug Tools"
echo "========================================="

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "❌ Not a git repository. These tools require git."
    exit 1
fi

# Make scripts executable
chmod +x git_change_tracker.sh
chmod +x workspace_change_monitor.py

echo "✅ Scripts made executable"

# Option to install globally
echo
read -p "Install 'real_changes' command globally? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo cp git_change_tracker.sh /usr/local/bin/real_changes
    echo "✅ 'real_changes' command installed globally"
    echo "   Usage: real_changes"
else
    echo "📋 To use locally: ./git_change_tracker.sh"
fi

echo
echo "🚀 Installation complete!"
echo
echo "Available tools:"
echo "• ./git_change_tracker.sh - Get accurate file change counts"
echo "• ./workspace_change_monitor.py - Monitor changes in real-time"
echo "• real_changes (if installed globally) - Quick file change check"
echo
echo "Now you can trust your file counts instead of VS Code's lies! 🎯"
