# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

if [ -f ~/.bash_exports.sh ]; then
    source ~/.bash_exports.sh
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

powershell.exe -c "Get-NetIPInterface | where {\$_.InterfaceAlias -eq 'vEthernet (WSL)' -or \$_.InterfaceAlias -eq 'vEthernet (Default Switch)' -or \$_.InterfaceAlias -eq 'vEthernet (vNAT)'} | Set-NetIPInterface -Forwarding Enabled 2> \$null"

if [ -e /home/doublew/.nix-profile/etc/profile.d/nix.sh ]; then . /home/doublew/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# >>> coursier install directory >>>
export PATH="$PATH:/home/doublew/.local/share/coursier/bin"
# <<< coursier install directory <<<
