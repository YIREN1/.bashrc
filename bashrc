
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

function dockerls() {
	docker ps -a -f "name=$CORE_PROJECT_NAME" --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}"
}

alias dls=dockerls
alias ga='git add -p'
alias gb='git branch'
alias gck='git checkout'
alias gcm='git commit -m'
alias gs='git status'
alias gps='git push -u origin'
alias gpl='git pull'
alias gf='git fetch'
alias gl='git log --pretty=format:"%h - %an, %ar : %s"'

alias bs='sed -u "s/^\([^|]*\)| //g" | bunyan -o short'

alias dk='docker'
alias dc='docker-compose'

PATH="$HOME/bin:$HOME/.local/bin:/usr/bin:$PATH"

alias ..="cd .."
alias ...="cd ../.."
alias cd..="cd .."

function list_projects() {
  docker ps --filter "label=com.docker.compose.project" -q | xargs docker inspect --format='{{index .Config.Labels "com.docker.compose.project"}}'| sort | uniq
}

alias dclp=list_projects

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

COLOR_RED="\033[0;31m"
BACK_COLOR_RED="\033[41m"
COLOR_YELLOW="\033[0;33m"
BACK_COLOR_YELLOW="\033[43m"
COLOR_GREEN="\033[0;32m"
BACK_COLOR_GREEN="\033[42m"
COLOR_OCHRE="\033[38;5;95m"
BACK_COLOR_OCHRE="\033[48m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"
function git_color {
  local git_status="$(git status 2> /dev/null)"

  if [[ ! $git_status =~ "working tree clean" ]]; then
    echo -e $COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo -e $COLOR_GREEN
  else
    echo -e $COLOR_OCHRE
  fi
}

function git_back_color {
  local git_status="$(git status 2> /dev/null)"

  if [[ ! $git_status =~ "working tree clean" ]]; then
    echo -e $BACK_COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $BACK_COLOR_YELLOW
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo -e $BACK_COLOR_GREEN
  else
    echo -e $BACK_COLOR_OCHRE
  fi
}

PS1="\[\033[36m\]ubuntu\[\033[m\]:\[\033[44m\]\[\033[8;30m\]\[\033[1;33m\]\w$"2
PS1+="\[\$(git_back_color)\]\[\033[34m\]\[\$(git_back_color)\]"
PS1+="\[\033[30m\]\$(parse_git_branch)\[\033[0;m\]\[\$(git_color)\]"
PS1+="\[\033[m\] [\[$(tput sgr0)\]\[\033[38;5;213m\]\A\[$(tput sgr0)\]\[\033[38;5;15m\]]"
PS1+="\n"
PS1+="\[$COLOR_BLUE\]\$\[$COLOR_RESET\]"
PS1+=" 🔥  🏀  😈  "
export PS1
#export PS1=" 🇨🇳  😎 📡  "

function goincontainer() {
    docker exec -it ${CORE_PROJECT_NAME}_$1_1 /bin/bash
}

alias goinbroker="goincontainer core-broker"
