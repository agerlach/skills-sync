user     := `whoami`
label    := "com." + user + ".sync-claude-skills"
plist    := home_dir() / "Library/LaunchAgents" / label + ".plist"
template := justfile_directory() / "sync-skills.plist"
script   := justfile_directory() / "sync-skills.sh"

# Run sync immediately
run:
    "{{script}}"

# Write plist and load the launchd agent
install:
    sed "s|__HOME__|$HOME|g; s|__LABEL__|{{label}}|g" "{{template}}" > "{{plist}}"
    launchctl load "{{plist}}"
    echo "Installed and loaded: {{label}}"

# Unload and remove the launchd agent
uninstall:
    -launchctl unload "{{plist}}"
    rm -f "{{plist}}"
    echo "Removed: {{label}}"

# Show agent status
status:
    launchctl list | grep "{{label}}" && echo "Running" || echo "Not loaded: {{label}}"
