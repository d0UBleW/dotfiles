export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/opt/exercism-cli/

export JAVA_HOME=/usr/lib/jvm/jdk-12

export PATH=$PATH:$JAVA_HOME/bin

export XDG_CONFIG_HOME=$HOME/.config

export PATH=$PATH:$HOME/Documents/scripts:$HOME/bin

export EDITOR=/usr/bin/vim

export DOTFILES="$HOME/.dotfiles"
export STOW_FOLDERS="vim,tmux"

# export VIRTUALENVWRAPPER_PYTHON="/usr/bin/python3"
# export WORKON_HOME="$HOME/.virtualenvs"
# source ~/.local/bin/virtualenvwrapper.sh

export AUTOENV_ENABLE_LEAVE=TRUE
export AUTOENV_ASSUME_YES=TRUE

# eval "$(mcfly init bash)"
# export MCFLY_LIGHT=TRUE
# export MCFLY_KEY_SCHEME=vim
# export MCFLY_FUZZY=2
# export MCFLY_RESULTS=50
# export MCFLY_INTERFACE_VIEW=BOTTOM
# export MCFLY_RESULTS_SORT=LAST_RUN
# export MCFLY_DISABLE_MENU=TRUE


export GOPATH=$HOME/projects/go
export GOROOT=/usr/local/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
export PATH=$PATH:$GOROOT/bin
export GO111MODULE=on
export WIN=$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}')

# Wasmer
export WASMER_DIR="/home/doublew/.wasmer"

export NVM_DIR="$HOME/.config/nvm"

# export LIMBION_DOWNLOADS="/mnt/c/Users/LEGION.LAPTOP-HVMBBO3R/Downloads"

export PATH=$PATH:/home/doublew/.cabal/bin
export PATH=$PATH:/usr/games

# bind '"\eh":"\e[D"'
# bind '"\ej":"\e[B"'
# bind '"\ek":"\e[A"'
# bind '"\el":"\e[C"'

export CC=clang
export CXX=clang++

export PATH=$PATH:/home/doublew/.cargo/bin
