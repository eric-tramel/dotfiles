# Eric's OSX Dotfiles

Here I am simply collecting all of my local terminal configurations into one place so that I never have to hunt around for these things again. Once and done!

## Terminal Software

- iTerm2 
    - Using colorscheme `Spacedust`
- Karabiner
    - Used for remapping `caps-lock` to `escape`.

## Setup

```
cd $HOME/src
git clone git@gihub.com:eric-tramel/dotfiles.git
git clone https://github.com/koirand/tokyo-metro.vim.git
ln -s $HOME/src/tokyo-metro.vim/colors/tokyo-metro.vim ~/.vim/colors/tokyo-metro.vim
ln -s $HOME/src/dotfiles/.vimrc ~/.vimrc
ln -s $HOME/src/dotfiles/.tmux.conf ~/.tmux.conf
ln -s $HOME/src/dotfiles/karabiner ~/.config/karabiner
```

## Resetting Key Presses

To speed things up on OSX, we want to increase the repeat and repeat delay. This used to be able to be accomplished through Karabiner, but not since some recent OSX changes, so we will instead need to use the following settings through terminal.

```bash
defaults write -g KeyRepeat 1.3
defaults write -g InitialKeyRepeat 10
```

## TODO


- Get `ctags` running for proper tag jumping in `vim`.
- Get fuzzy file switching up and going (may just be training)
    - Check on that vim video where the guy was doing everything without pugins and had the demonstration of using the `**` indicator to allow for searching within subdirectories automatically.
