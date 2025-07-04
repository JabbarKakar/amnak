#!/bin/sh

# The default execution directory of this script is the ci_scripts directory.
cd $CI_PRIMARY_REPOSITORY_PATH # change working directory to the root of your cloned repo.

# Install Flutter using fvm.
brew tap leoafarias/fvm
brew install fvm
fvm install 3.19.6
fvm global 3.19.6

# Install Flutter artifacts for iOS (--ios), or macOS (--macos) platforms.
fvm flutter precache --ios

# Install Flutter dependencies.
fvm flutter pub get

# Install CocoaPods using Homebrew.
HOMEBREW_NO_AUTO_UPDATE=1 # disable homebrew's automatic updates.
brew install cocoapods

export GEM_HOME="$HOME/.gem"
gem install cocoapods
# Install CocoaPods dependencies.
cd ios && rm -rf Pods && gem install cocoapods && pod install
sudo arch -x86_64 gem install ffi
arch -x86_64 pod install

exit 0