install:
	# Source: https://github.com/mathiasbynens/dotfiles/blob/master/.macos

	# ABC
	defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
	defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
	defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
	defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
	defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

	# Keyboard
	defaults write NSGlobalDomain KeyRepeat -int 2
	defaults write NSGlobalDomain InitialKeyRepeat -int 25
	defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

	# Localisation
	defaults write NSGlobalDomain AppleLanguages -array "en"
	defaults write NSGlobalDomain AppleLocale -string "en_GB@currency=GBP"
	defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
	defaults write NSGlobalDomain AppleMetricUnits -bool true

	# Screensaver
	defaults write com.apple.screensaver askForPassword -int 1
	defaults write com.apple.screensaver askForPasswordDelay -int 0

	# Finder
	defaults write NSGlobalDomain AppleShowAllExtensions -bool true
	defaults write com.apple.finder ShowStatusBar -bool true
	defaults write com.apple.finder ShowPathbar -bool true
	defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
	defaults write com.apple.finder _FXSortFoldersFirst -bool true
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
	defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
	defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
	defaults write com.apple.frameworks.diskimages skip-verify -bool true
	defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
	defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true
	defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

	# Dock
	defaults write com.apple.dock tilesize -int 48
	defaults write com.apple.dock minimize-to-application -bool true

	# Terminal
	defaults write com.apple.terminal StringEncodings -array 4
	defaults write com.apple.terminal SecureKeyboardEntry -bool true

	# App Store
	defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
	defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
	defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1
	defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1
	defaults write com.apple.commerce AutoUpdate -bool true
	defaults write com.apple.commerce AutoUpdateRestartRequired -bool true
