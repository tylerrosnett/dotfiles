#!/usr/bin/env bash
# macOS preferences. Safe to re-run. Some changes need logout/restart.
set -euo pipefail
[[ "$(uname -s)" == Darwin ]] || { echo "macOS only"; exit 0; }

# Keyboard: fast repeat, no press-and-hold accent popup
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Disable smart quotes/dashes/autocorrect (terminal + code pasting)
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Finder: show extensions, path bar, hidden files; default to list view
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Dock: autohide, no recents, smaller tiles
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -int 85
# Unpin all apps (running apps still appear)
defaults write com.apple.dock persistent-apps -array
# No open-app indicator dots
defaults write com.apple.dock show-process-indicators -bool false
# Minimize into the app's icon, not a separate window thumbnail
defaults write com.apple.dock minimize-to-application -bool true

# Screenshots → ~/Screenshots, no shadow
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"
defaults write com.apple.screencapture disable-shadow -bool true

# Screenshot hotkeys: ⌘⇧4 copies selection to CLIPBOARD instead of saving a file.
# Symbolic hotkey IDs: 30 = save selection as file, 31 = copy selection to clipboard.
# Disable the save-to-file binding on ⌘⇧4...
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 30 \
  '<dict><key>enabled</key><false/></dict>'
# ...and rebind copy-to-clipboard from ⌘⌃⇧4 to ⌘⇧4
# parameters: 52 = ASCII "4", 21 = keycode for "4", 1179648 = Cmd(1048576)+Shift(131072)
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 31 \
  '<dict><key>enabled</key><true/><key>value</key><dict><key>type</key><string>standard</string><key>parameters</key><array><integer>52</integer><integer>21</integer><integer>1179648</integer></array></dict></dict>'
# "Move focus to next window" (cycle same-app windows): ⌘` default → ⌘Esc
# (custom keyboard: backtick lives on a layer, Esc is the physical key)
# ID 27; parameters: 65535 = no ASCII char, 53 = Esc keycode, 1048576 = Cmd
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 27 \
  '<dict><key>enabled</key><true/><key>value</key><dict><key>type</key><string>standard</string><key>parameters</key><array><integer>65535</integer><integer>53</integer><integer>1048576</integer></array></dict></dict>'

# Disable Game Overlay (ID 260) — its default ⌘Esc conflicts with window cycling above
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 260 \
  '<dict><key>enabled</key><false/><key>value</key><dict><key>type</key><string>standard</string><key>parameters</key><array><integer>65535</integer><integer>53</integer><integer>1048576</integer></array></dict></dict>'

# Make the hotkey changes take effect without logout
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u 2>/dev/null || true

# Don't write .DS_Store on network/USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Save dialogs expanded by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

killall Finder Dock SystemUIServer 2>/dev/null || true
echo "macOS defaults applied (keyboard changes need logout/login)."
