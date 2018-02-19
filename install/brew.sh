echo "Installing Brew..."

# install brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# newest version of brew and packages
brew update
brew upgrade

# Install packages
brew_apps=(
  hardlink-osx
  git
  imagesnap
  pandoc
  pandoc-citeproc
  python
  shpotify
  thefuck
)

brew install "${brew_apps[@]}"
