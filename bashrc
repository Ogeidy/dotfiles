##### STANDART UBUNTU PART #####

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=11000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


##### CUSTOM PART #####

# Aliases
# alias docker="sudo docker"
# alias docker-compose="sudo docker-compose"
alias ll="ls -lah"
alias l="ls -lh"

alias my_bat="echo 'Battery:' && upower -i $(upower -e | grep 'BAT') | grep -E 'state|energy:|energy-rate|voltage|time\ to|percentage'"
alias my_temp="sensors coretemp-isa-0000 thinkpad-isa-0000 BAT0-acpi-0 pch_cannonlake-virtual-0 nvme-pci-3d00 acpitz-acpi-0 iwlwifi_1-virtual-0 | grep -vE 'thinkpad-isa-0000|coretemp-isa-0000|temp3|temp4|temp6|temp7|temp8|^$'"
alias my_stat="my_temp && my_bat"
alias my_stat_w="watch -n 2 \"sensors coretemp-isa-0000 thinkpad-isa-0000 BAT0-acpi-0 pch_cannonlake-virtual-0 nvme-pci-3d00 acpitz-acpi-0 iwlwifi_1-virtual-0 | grep -vE 'thinkpad-isa-0000|coretemp-isa-0000|temp3|temp4|temp6|temp7|temp8|^$' && echo 'Battery:' && upower -i $(upower -e | grep 'BAT') | grep -E 'state|energy:|energy-rate|voltage|time\ to|percentage'\""
alias dfh="df -h | grep -v '/dev/loop' | grep -v 'tmpfs'"

# Prompt customization
colors=("14;1"   # cyan
        "28;1"   # dark green
        "27;1"   # blue
        "76;1"   # green
        "92;1"   # lilac
        "94;1"   # brown
        "165;1"  # purple
        "166;1"  # orange
        "226;1") # yellow
time_color='244'          # grey
prompt_color='76;1'       # green
tmux_prompt_color='76;1'  # green
root_prompt_color='196;1' # red
tmux_random_color=yes
#prompt_random_color=yes

if [ "$tmux_random_color" = yes ]; then
    tmux_prompt_color=${colors[$(($RANDOM % ${#colors[@]}))]}
fi

if [ "$prompt_random_color" = yes ]; then
    prompt_color=${colors[$(($RANDOM % ${#colors[@]}))]}
fi

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
    screen) color_prompt=yes; prompt_color=$tmux_prompt_color;;
    linux) color_prompt=yes; prompt_color='76;1';;
esac

if [[ $UID == 0 ]] ; then
    prompt_color=$root_prompt_color
fi

if [ "$color_prompt" = yes ]; then
    PS1='\[\e[38;5;'$time_color'm\]\t j\j \[\e[38;5;'$prompt_color'm\]\u@\h\[\e[0m\]:\[\e[01;34m\]\w\n\[\e[38;5;'$prompt_color'm\]\$\[\e[0m\] '
else
    PS1='\t j\j \u@\h:\w\n\$ '
fi
unset colors time_color prompt_color tmux_prompt_color root_prompt_color tmux_tandom_color color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*) PS1="\[\e]0;\u@\h: \w\a\]$PS1";;
    *) ;;
esac

export PIPENV_VENV_IN_PROJECT=1
