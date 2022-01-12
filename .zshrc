
# Custom Options

# Change Prompt
# %B%b starts/stops bold
# %F%f starts foreground color, xterm color from 0 to 256
# %n is username
# %~ is current path with number denoting how many directories to show
# %# is the end of prompt symbol % by default
PROMPT='%B%F{green}%n:%F{27}%1~%f%b %# '

# Alias definitions
alias ls='ls -G'
alias la='ls -a -G'


#AUTO LAUNCH SSH AGENT
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
      (umask 077; ssh-agent >| "$env")
      . "$env" >| /dev/null ; }

agent_load_env

#agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)
          
if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi
          
unset env 
# END AUTO LAUNCH SSH AGENT

# ADD SSH KEYS
ssh-add ~/.ssh/devliang_github 2>/dev/null
export PATH=$PATH:"/c/Program Files/Java/jdk-12.0.1/"

# Make default text editor vim
export VISUAL=vim
export EDITOR="$VISUAL"
export DISPLAY=:0
DOCKER_HOST=tcp://localhost:2375
