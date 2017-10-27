# fzf - Fuzzy find
# Mostly drawn from https://github.com/junegunn/fzf/wiki/examples

if [ -f ~/.fzf.bash ];
then
    source ~/.fzf.bash

    if [ "$(which ag)" ];
    then
        # Use ag "the silver searcher" as the default file listing command if
        # possible
        export FZF_DEFAULT_COMMAND='ag -g . 2> /dev/null';

        # Fuzzy ag / ack / grep -rn
        agf() {
            ag --noheading . | fzf
        }
    fi

    # v - fuzzy find file if one is not given
    v() {
      if [[ $# -eq 0 ]];
      then
          # If no file is given, pick one from the list
          local files
          IFS=$'\n' files=($(fzf --query="$*" --multi --select-1 --exit-0))
          [[ -n "$files" ]] && smart_vopen "${files[@]}"
      else
          smart_vopen $@
      fi
    }

    # vp - Open a previously opened file in vim
    vp() {
         local files
          files=$(grep '^>' ~/.viminfo | cut -c3- |
                  while read line; do
                    [ -f "${line/\~/$HOME}" ] && echo "$line"
                  done | fzf --query="$*" --multi --select-1 --exit-0) && vim "${files//\~/$HOME}"
    }

    # fup - cd up to a parent directory
    # Potential bug with symbolic links and/or filenames with spaces
    fup() {
      local declare dirs=()
      get_parent_dirs() {
        if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
        if [[ "${1}" == '/' ]]; then
          for _dir in "${dirs[@]}"; do echo $_dir; done
        else
          get_parent_dirs $(dirname "$1")
        fi
      }
      local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf --tac)
      cd "$DIR"
    }

    # fkill - kill process
    fkill() {
      local pid
      pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

      if [ "x$pid" != "x" ]
      then
        echo $pid | xargs kill -${1:-9}
      fi
    }

    # Add fuzzy commit finder and log filter if git is installed
    if [ "$(which git)" ];
    then
        # gcom - copy commit SHA, to be used later in rebase or checkout
        gcom() {
          local commits commit
          commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
          commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&
          echo -n $(echo "$commit" | sed "s/ .*//") | pbcopy
        }

        # glf - git log fuzzy filter
        glf() {
          git log --graph --color=always \
              --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
          fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
              --bind "ctrl-m:execute:
                        (grep -o '[a-f0-9]\{7\}' | head -1 |
                        xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                        {}
        FZF-EOF"
        }
    fi

    # Add completion for my aliases
    complete -F _fzf_dir_completion -o default -o bashdefault gn

else
    >&2 echo 'fzf bash module not loaded - could not find .fzf.bash';
fi


