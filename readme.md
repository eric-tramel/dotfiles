# Eric's OSX Dotfiles

Here I am simply collecting all of my local terminal configurations into one place so that I never have to hunt around for these things again. Once and done!

## Terminal Software

## Setup

```
cd $HOME/src
git clone git@gihub.com:eric-tramel/dotfiles.git
ln -s $HOME/src/dotfiles/nvim ~/.config/nvim
ln -s $HOME/src/dotfiles/.tmux.conf ~/.tmux.conf
```

## Resetting Key Presses

To speed things up on OSX, we want to increase the repeat and repeat delay. This used to be able to be accomplished through Karabiner, but not since some recent OSX changes, so we will instead need to use the following settings through terminal.

```bash
defaults write -g KeyRepeat 1.3
defaults write -g InitialKeyRepeat 10
```

## TODO

- Integration with [chezmoi](chezmoi.io)?

