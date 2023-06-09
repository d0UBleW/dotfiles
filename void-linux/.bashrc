# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias cat='bat'
alias ls='lsd'
alias ll='ls -l'
alias la='ls -al'
alias tree='lsd --tree'
alias nf='neofetch'
alias src="source ~/.bashrc"
alias g='git'
alias hc='herbstclient'
alias mpc='mpc --host=/home/d0ublew/.config/mpd/socket'
alias py='python3'
alias ipy='ipython3 --no-banner'
alias ta='tmux attach'
alias docker='podman'
# https://unix.stackexchange.com/a/690130 to get alias completion

alias cfbrc="vim ~/.bashrc"
alias cfala="vim ~/.config/alacritty/alacritty.yml"
alias cfhlwm="vim ~/.config/herbstluftwm/autostart"
alias cfpb="vim ~/.config/polybar/config.ini"
alias cfeww="vim ~/.config/eww/eww.yuck"
alias cfnvim="vim ~/.config/nvim/init.lua"
alias cftm="vim ~/.tmux.conf"

PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"
export QT_QPA_PLATFORMTHEME=gtk2

export PATH="$HOME/bin:$PATH"
export PATH="/home/d0ublew/.local/share/nvim/mason/bin:$PATH"
export PATH="/home/d0ublew/.local/bin:$PATH"
. "$HOME/.cargo/env"

export VAULT_PASSWORD='password'

# . /usr/share/bash-completion/completions/podman
# __docker_podman_comp=$(complete -p podman)
# eval "${__docker_podman_comp% *} docker"
# unset __docker_podman_comp
