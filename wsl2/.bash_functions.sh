autoenv_enable () {
    source ~/.autoenv/activate.sh
}

autoenv_disable () {
    unset cd
}

__peco_select_dir ()
{
    if command -v fd >/dev/null 2>&1; then
        builtin typeset DIR="$(command fd --type directory --hidden --no-ignore --exclude .git/ --color never | peco )"
    else
        builtin typeset DIR="$(
        command find \( -path '*/\.*' -o -fstype dev -o -fstype proc \) -type f -print 2> /dev/null \
            | sed 1d \
            | cut -b3- \
            | awk '{a[length($0)" "NR]=$0}END{PROCINFO["sorted_in"]="@ind_num_asc"; for(i in a) print a[i]}' - \
            | peco
                    )"
    fi

    if [[ -n $DIR ]]; then
        builtin bind '"\er": redraw-current-line'
        builtin bind '"\e^": magic-space'

        DIR=$(printf %q "$DIR")

        READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${DIR}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
        READLINE_POINT=$(( READLINE_POINT + ${#DIR} ))
    else
        builtin bind '"\er":'
        builtin bind '"\e^":'
    fi
}

__peco_select_file ()
{
    if command -v fd >/dev/null 2>&1; then
        builtin typeset FILE="$(command fd --type file --full-path --hidden --no-ignore --exclude .git/ --color never . | peco)"
    elif command -v rg >/dev/null 2>&1; then
        builtin typeset FILE="$(rg --glob "" --files --hidden --no-ignore-vcs --iglob !.git/ --color never | peco)"
    elif command -v ag >/dev/null 2>&1; then
        builtin typeset FILE="$(ag --files-with-matches --unrestricted --skip-vcs-ignores --ignore .git/ --nocolor -g "" | peco)"
    else
        builtin typeset FILE="$(
        command find \( -path '*/\.*' -o -fstype dev -o -fstype proc \) -type f -print 2> /dev/null \
            | sed 1d \
            | cut -b3- \
            | awk '{a[length($0)" "NR]=$0}END{PROCINFO["sorted_in"]="@ind_num_asc"; for(i in a) print a[i]}' - \
            | peco
                    )"
    fi

    if [[ -n $FILE ]]; then
        builtin bind '"\er": redraw-current-line'
        builtin bind '"\e^": magic-space'

        FILE=$(printf %q "$FILE")

        READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${FILE}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
        READLINE_POINT=$(( READLINE_POINT + ${#FILE} ))
    else
        builtin bind '"\er":'
        builtin bind '"\e^":'
    fi
}

bind -m emacs -x '"\e\C-xf": __peco_select_dir'
bind -m emacs '"\C-xf": "\e\C-xf\e^\er"'
bind -m emacs -x '"\e\C-x\C-f": __peco_select_file'
bind -m emacs '"\C-x\C-f": "\e\C-x\C-f\e^\er"'

__peco_change_dir () {
    declare -A FILTER_LIST=( [Fuzzy]=1 [IgnoreCase]=1 [Regexp]=1 [SmartCase]=1 [CaseSensitive]=1 )
    FILTER="Fuzzy"
    local OPTIND=1
    while getopts ":f:" opts; do
        case ${opts} in
            f)
                FILTER=${OPTARG}
                ;;
            :)
                echo "Error: -${OPTARG} requires an argument."
                ;;
        esac
    done
    shift $((OPTIND - 1))
    
    if ! [[ ${FILTER_LIST["${FILTER}"]} ]]; then
        echo "Unknown filter"
        return 1
    fi

    PECO_RC="$XDG_CONFIG_HOME/peco/config.json"
    PECO_FLAGS="--rcfile ${PECO_RC} --initial-filter ${FILTER}"
    if [[ "$#" -ne 0 ]]; then
        TARGET_DIR=$(find $1 -type f 2>/dev/null | peco ${PECO_FLAGS})
    else
        TARGET_DIR=$(find $HOME -type f 2>/dev/null | peco ${PECO_FLAGS})
    fi
    EXIT_STATUS=$?

    if [[ "${EXIT_STATUS}" -eq 0 ]]; then
        cd ${TARGET_DIR}
        return 0
    else
        return $?
    fi
}

__peco_open_file () {
    declare -A FILTER_LIST=( [Fuzzy]=1 [IgnoreCase]=1 [Regexp]=1 [SmartCase]=1 [CaseSensitive]=1 )
    FILTER="Fuzzy"
    local OPTIND=1
    while getopts ":f:" opts; do
        case ${opts} in
            f)
                FILTER=${OPTARG}
                ;;
            :)
                echo "Error: -${OPTARG} requires an argument."
                ;;
        esac
    done
    shift $((OPTIND - 1))
    
    if ! [[ ${FILTER_LIST["${FILTER}"]} ]]; then
        echo "Unknown filter"
        return 1
    fi

    PECO_RC="$XDG_CONFIG_HOME/peco/config.json"
    PECO_FLAGS="--rcfile ${PECO_RC} --initial-filter ${FILTER}"
    if [[ "$#" -ne 0 ]]; then
        TARGET_FILE=$(find $1 -type f 2>/dev/null | peco ${PECO_FLAGS})
    else
        TARGET_FILE=$(find $HOME -type f 2>/dev/null | peco ${PECO_FLAGS})
    fi
    EXIT_STATUS=$?

    if [[ "${EXIT_STATUS}" -eq 0 ]]; then
        vim ${TARGET_FILE}
        return 0
    else
        return $?
    fi
}
