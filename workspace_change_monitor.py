#!/usr/bin/env python3
"""
Workspace Change Monitor - The Truth About Your Files
Because VS Code's file counter is about as reliable as a chocolate teapot.
"""

import os
import subprocess
import time
from pathlib import Path

def get_git_changes():
    """Get actual file changes from git - the source of truth."""
    try:
        # Staged files
        staged = subprocess.check_output(
            ['git', 'diff', '--cached', '--name-only'], 
            text=True
        ).strip().split('\n')
        staged = [f for f in staged if f]
        
        # Unstaged changes
        unstaged = subprocess.check_output(
            ['git', 'diff', '--name-only'], 
            text=True
        ).strip().split('\n') 
        unstaged = [f for f in unstaged if f]
        
        # Untracked files
        untracked = subprocess.check_output(
            ['git', 'ls-files', '--others', '--exclude-standard'],
            text=True
        ).strip().split('\n')
        untracked = [f for f in untracked if f]
        
        return {
            'staged': staged,
            'unstaged': unstaged, 
            'untracked': untracked,
            'total': len(staged) + len(unstaged) + len(untracked)
        }
    except subprocess.CalledProcessError:
        return None

def monitor_workspace():
    """Monitor workspace and report REAL change counts."""
    print("🔍 Monitoring workspace changes...")
    print("Press Ctrl+C to stop\n")
    
    last_count = 0
    
    try:
        while True:
            changes = get_git_changes()
            if changes:
                current_count = changes['total']
                
                if current_count != last_count:
                    print(f"📊 Real file changes: {current_count}")
                    print(f"   📁 Staged: {len(changes['staged'])}")
                    print(f"   📝 Unstaged: {len(changes['unstaged'])}")
                    print(f"   ❓ Untracked: {len(changes['untracked'])}")
                    print(f"   🕐 {time.strftime('%H:%M:%S')}")
                    print("-" * 40)
                    
                last_count = current_count
            
            time.sleep(2)
            
    except KeyboardInterrupt:
        print("\n👋 Monitoring stopped.")

if __name__ == "__main__":
    if not Path('.git').exists():
        print("❌ Not a git repository. VS Code's lying about non-git files too?")
        exit(1)
        
    monitor_workspace()
