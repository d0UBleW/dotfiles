export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/opt/exercism-cli/

export JAVA_HOME=/usr/lib/jvm/jdk-12

export PATH=$PATH:$JAVA_HOME/bin

export XDG_CONFIG_HOME=$HOME/.config

export PATH=$PATH:$HOME/scripts:$HOME/bin

export EDITOR=/usr/bin/nvim

export DOTFILES="$HOME/.dotfiles"
export STOW_FOLDERS="tmux"

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

export PYENV_ROOT="$HOME/.pyenv"

export VAGRANT_WSL_WINDOWS_ACCESS_USER_HOME_PATH=/mnt/c/Users/William
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS=1
export PATH="$PATH:/mnt/c/Program Files/Oracle/VirtualBox"
# export PATH=$PATH:/mnt/c/Windows/System32/
# export PATH="$PATH:/mnt/c/ProgramData/Microsoft/Windows/Hyper-V/"
export VAGRANT_DEFAULT_PROVIDER=hyperv
# export VAGRANT_DEFAULT_PROVIDER=virtualbox
export VAGRANT_DISABLE_VBOXSYMLINKCREATE=1
