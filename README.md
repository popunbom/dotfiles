# dotfiles

My dotfiles

## Includes

### dotfiles
- zsh
   + Prezto
- vim
   + NeoBundle
- bash
- latexmkrc

### Configs
- Sublime Text 3
- iTerm2
- PyCharm

## How to Setup
1. Clone repository

```bash
git clone --recursive https://github.com/popunbom/dotfiles ~/.dotfiles

```

2. Run `setup.sh`
```bash
~/.dotfiles/setup.sh
```

### for Vim
For the first time, run this command
```vim
:NeoBundleInstall
```


## How to restore some Apps settings

### Sublime Text 3
1. Run `setup_subl.sh`
```bash
~/.dotfiles/configs/SublimeText3/setup_subl.sh
```

### PyCharm (JetBrains IDE)
`File` -> `Import Settings` and choose propery `*.jar` settings file

### iTerm2
1. `iTerm2` -> `Preferences`
1. Check `Load preferences from a custom folder or URL` and set path to `~/dotfiles/configs/iTerm2` 
1. Restart, to apply settings


## Author
popunbom
