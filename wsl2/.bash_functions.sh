autoenv_enable () {
    source ~/.autoenv/activate.sh
}

autoenv_disable () {
    unset cd
}

__peco_select_dir ()
{
    PECO_FLAGS="--prompt \"DIR>\""
    if command -v fd >/dev/null 2>&1; then
        builtin typeset DIR="$(command fd --type directory --hidden --no-ignore --exclude .git/ --color never | peco ${PECO_FLAGS} )"
    else
        builtin typeset DIR="$(
        command find \( -path '*/\.*' -o -fstype dev -o -fstype proc \) -type f -print 2> /dev/null \
            | sed 1d \
            | cut -b3- \
            | awk '{a[length($0)" "NR]=$0}END{PROCINFO["sorted_in"]="@ind_num_asc"; for(i in a) print a[i]}' - \
            | peco ${PECO_FLAGS}
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
    PECO_FLAGS="--prompt \"FILE>\""
    if command -v fd >/dev/null 2>&1; then
        builtin typeset FILE="$(command fd --type file --full-path --hidden --no-ignore --exclude .git/ --color never . | peco ${PECO_FLAGS})"
    elif command -v rg >/dev/null 2>&1; then
        builtin typeset FILE="$(rg --glob "" --files --hidden --no-ignore-vcs --iglob !.git/ --color never | peco ${PECO_FLAGS})"
    elif command -v ag >/dev/null 2>&1; then
        builtin typeset FILE="$(ag --files-with-matches --unrestricted --skip-vcs-ignores --ignore .git/ --nocolor -g "" | peco ${PECO_FLAGS})"
    else
        builtin typeset FILE="$(
        command find \( -path '*/\.*' -o -fstype dev -o -fstype proc \) -type f -print 2> /dev/null \
            | sed 1d \
            | cut -b3- \
            | awk '{a[length($0)" "NR]=$0}END{PROCINFO["sorted_in"]="@ind_num_asc"; for(i in a) print a[i]}' - \
            | peco ${PECO_FLAGS}
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

__peco_select_history ()
{
    PECO_FLAGS="--prompt \"DIR>\""
    builtin typeset HIST="$(history | cut -d ' ' -f4- | sort | uniq | peco ${PECO_FLAGS} )"

    if [[ -n $HIST ]]; then
        builtin bind '"\er": redraw-current-line'
        builtin bind '"\e^": magic-space'

        HIST=$(printf %s "$HIST")

        READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${HIST}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
        READLINE_POINT=$(( READLINE_POINT + ${#HIST} ))
    else
        builtin bind '"\er":'
        builtin bind '"\e^":'
    fi
}

bind -m emacs -x '"\e\C-xf": __peco_select_dir'
bind -m emacs '"\C-xf": "\e\C-xf\e^\er"'

bind -m emacs -x '"\e\C-x\C-f": __peco_select_file'
bind -m emacs '"\C-x\C-f": "\e\C-x\C-f\e^\er"'

bind -m emacs -x '"\e\C-xr": __peco_select_history'
bind -m emacs '"\C-xr": "\e\C-xr\e^\er"'

bind -m emacs -x '"\e\C-x\C-r": __peco_select_history'
bind -m emacs '"\C-x\C-r": "\e\C-x\C-r\e^\er"'

__peco_change_dir () {
    # declare -A FILTER_LIST=( [Fuzzy]=1 [IgnoreCase]=1 [Regexp]=1 [SmartCase]=1 [CaseSensitive]=1 )
    # FILTER="Fuzzy"
    # local OPTIND=1
    # while getopts ":f:" opts; do
    #     case ${opts} in
    #         f)
    #             FILTER=${OPTARG}
    #             ;;
    #         :)
    #             echo "Error: -${OPTARG} requires an argument."
    #             ;;
    #     esac
    # done
    # shift $((OPTIND - 1))
    
    # if ! [[ ${FILTER_LIST["${FILTER}"]} ]]; then
    #     echo "Unknown filter"
    #     return 1
    # fi

    FILTER_LIST="Fuzzy IgnoreCase Regexp SmartCase CaseSensitive"
    FILTER="SmartCase"
    local OPTIND=1
    while getopts ":f" opts; do
        case ${opts} in
            f)
                FILTER=$(echo ${FILTER_LIST} | tr ' ' '\n' | peco --prompt "FILTER")
                if echo ${FILTER_LIST} | grep -qs ${FILTER} 2>/dev/null; then
                    :
                else
                    echo "Please choose a filter"
                    return 1
                fi
                ;;
            :)
                echo "Error: -${OPTARG} requires an argument."
                return 1
                ;;
            *)
                echo "Error: -${OPTARG} is not a valid option."
                return 1
                ;;
        esac
    done
    shift $((OPTIND - 1))

    PECO_RC="$XDG_CONFIG_HOME/peco/config.json"
    PECO_FLAGS="--rcfile ${PECO_RC} --initial-filter ${FILTER}"
    if [[ "$#" -ne 0 ]]; then
        TARGET_DIR=$(find $1 -type d 2>/dev/null | peco ${PECO_FLAGS})
    else
        TARGET_DIR=$(find $HOME -type d 2>/dev/null | peco ${PECO_FLAGS})
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
    # declare -A FILTER_LIST=( [Fuzzy]=1 [IgnoreCase]=1 [Regexp]=1 [SmartCase]=1 [CaseSensitive]=1 )
    # FILTER="Fuzzy"
    # local OPTIND=1
    # while getopts ":f:" opts; do
    #     case ${opts} in
    #         f)
    #             FILTER=${OPTARG}
    #             ;;
    #         :)
    #             echo "Error: -${OPTARG} requires an argument."
    #             ;;
    #     esac
    # done
    # shift $((OPTIND - 1))
    
    # if ! [[ ${FILTER_LIST["${FILTER}"]} ]]; then
    #     echo "Unknown filter"
    #     return 1
    # fi

    FILTER_LIST="Fuzzy IgnoreCase Regexp SmartCase CaseSensitive"
    FILTER="SmartCase"
    local OPTIND=1
    while getopts ":f" opts; do
        case ${opts} in
            f)
                FILTER=$(echo ${FILTER_LIST} | tr ' ' '\n' | peco --prompt "FILTER")
                if echo ${FILTER_LIST} | grep -qs ${FILTER} 2>/dev/null; then
                    :
                else
                    echo "Please choose a filter"
                    return 1
                fi
                ;;
            :)
                echo "Error: -${OPTARG} requires an argument."
                return 1
                ;;
            *)
                echo "Error: -${OPTARG} is not a valid option."
                return 1
                ;;
        esac
    done
    shift $((OPTIND - 1))

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
