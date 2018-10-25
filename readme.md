# Eric's OSX Dotfiles

Here I am simply collecting all of my local terminal configurations into one place so that I never have to hunt around for these things again. Once and done!

## Terminal Software

- iTerm2 
    - Using colorscheme `Spacedust`
- Karabiner
    - Used for remapping `caps-lock` to `escape`.

## Resetting Key Presses

To speed things up on OSX, we want to increase the repeat and repeat delay. This used to be able to be accomplished through Karabiner, but not since some recent OSX changes, so we will instead need to use the following settings through terminal.

```bash
defaults write -g KeyRepeat 1.3
defaults write -g InitialKeyRepeat 10
```

## TODO

- ~~Get fold-jumping comitted (copy from work remote)~~

- Get `ctags` running for proper tag jumping in `vim`.
- Get fuzzy file switching up and going (may just be training)
    - Check on that vim video where the guy was doing everything without pugins and had the demonstration of using the `**` indicator to allow for searching within subdirectories automatically.
- Remap save to something nice and easy (`ctrl-s`?)
- ~~Figure out why the capslock escape is slow.~~
- Get a better understanding of completions
- Set-up a snippet or skeleton for doing numpydocs comments
- Get `black` to run on save calls (along with `savetags`).
- ~~Research Markdown-specific plugins for `vim`.~~
    - Get word-wrapping to activate based on file type, along with text limit
    - Use non-breaking spaces for markdown, but use breaking spaces for tex.
-  Learn how to use `fugitive` correctly for manging git projects and save myself a lot of time fusing with commits.
