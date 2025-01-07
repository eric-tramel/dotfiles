# Eric's OSX Dotfiles

Here I am simply collecting all of my local terminal configurations into one place so that I never have to hunt around for these things again. Once and done!

## Setup 

The main idea here is to excise `brew` and rely entirely on a programmatic definition of the system. This gets around the "oh I forgot this one weird trick" problem of local setups. Furthermore, using the approach here doesn't "poison" your system -- if you want to change something in the configuration, you can do that and easily resync your system and bam, you are now in a different state. Beautiful encapsulation ❤️

### Install Determinate Nix

The setup is based entirely around `nix` and `home-manager`. To be able to start, you'll first need to install `nix`. At first this seems to be a tall order, but in truth, there are some quite good setup tools these days. Specifically, Determinate makes a good solution, you can find [their documentation here](https://docs.determinate.systems/getting-started). However, it seems like you should be able to get away with the following all-in-one command.

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install --determinate
```

### Dotfiles Setup

Note that if you have custom `.zsh` etc configurations, you will need to find out how to port them into the your fork of `home.nix`, otherwise you're going to end up with `nix` conflicts with your existing files. 

```
$ git clone git@github.com:git@github.com:eric-tramel/dotfiles.git
$ cd dotfiles
$ ln -s $home-manager $HOME/.config/home-manager
$ cd $HOME/.config/home-manager
$ nix flake update
$ home-manager switch
```


## Resetting Key Presses

To speed things up on OSX, we want to increase the repeat and repeat delay. This used to be able to be accomplished through Karabiner, but not since some recent OSX changes, so we will instead need to use the following settings through terminal.

```bash
defaults write -g KeyRepeat 1.3
defaults write -g InitialKeyRepeat 10
```
