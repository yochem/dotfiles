if ! is-macos -o ! is-executable brew; then
  echo "Skipped: Homebrew-Cask"
  return
fi

brew tap caskroom/cask
brew tap caskroom/versions
brew tap caskroom/fonts

cask_apps=(
  arduino
  atom
  dropbox
  fritzing
  github
  google-chrome
  hyper
  makerbot-print
  skype
  spotify
  telegram
  vuze
  whatsapp
)
# TODO: google drive

brew cask install "${cask_apps[@]}"
