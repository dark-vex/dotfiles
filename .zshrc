# Path to your dotfiles.
export DOTFILES=$HOME/.dotfiles

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"

ZSH_THEME="agnoster"
DEFAULT_USER=$USER

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$DOTFILES

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-prompt kube-ps1 zsh-interactive-cd vscode terraform gcloud 1password kubectl chucknorris brew history fzf kops kubectx oc sublime)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
# Wireshark TLS decryption
# https://wiki.wireshark.org/TLS#tls-decryption
export SSLKEYLOGFILE=~/.ssl-key.log

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# K8s completion not needed with oh-my-zsh kubectl plugin
#[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
[[ /usr/local/bin/eksctl ]] && source <(eksctl completion zsh)

#. $(pack completion --shell zsh)

# SeKey ssh auth with touch-id
export SSH_AUTH_SOCK=$HOME/.sekey/ssh-agent.ssh

# Git completion
fpath=(~/.zsh $fpath)

# SDC-Cli
# eval "$(_SDC_CLI_COMPLETE=source_zsh sdc-cli)"
##export PATH="/usr/local/sbin:$PATH"

# Ansible multi thread
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# Kubernetes Context and Namespace info
source $ZSH/plugins/kube-ps1/kube-ps1.plugin.zsh
RPROMPT='[%D{%f/%m/%y} %D{%K:%M:%S}]'$RPROMPT
PROMPT='$(kube_ps1)$(tf_prompt_info)'$PROMPT

# New line for ZSH 
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
      print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
      print -n "%{%k%}"
  fi

  print -n "%{%f%}"
  CURRENT_BG='' 

  #Adds the new line and ➜ as the start character.
  printf "\n ➜";
}

# Daniele shortcuts for moving one word backward/forward and moving to beginning/end of line
# https://stackoverflow.com/a/10485061/6544892
# https://coderwall.com/p/a8uxma/zsh-iterm2-osx-shortcuts

export PATH="${PATH}:${HOME}/.krew/bin"

# Configure gopath
export GOPATH=$HOME/go
export PATH=$PATH:$(go env GOPATH)/bin

# ASDF Kubectl version switcher
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# One Password CLI
source ~/.config/op/plugins.sh

# Install a new Kubectl version using asdf and fzf
ai() {
  local name
  if [[ $# -eq 0 ]]; then
    name=$(asdf plugin list | fzf)
  else
    name=$1
  fi
  asdf install $name $({ comm -23 <(asdf list all $name | sort --version-sort) <(asdf list $name | awk '{print $1}' | sort --version-sort); echo "latest"; } | fzf)
}

# Switch to a new Kubectl version using asdf and fzf
au() {
  local name
  if [[ $# -eq 0 ]]; then
    name=$(asdf plugin list | fzf)
  else
    name=$1
  fi
  local current=$(asdf current $name | awk '{print $2}')
  #asdf global $name $({asdf list $name | awk '{print $1}' | grep -v "^\*"; echo "latest"; } | fzf)
  ##asdf local $name $({asdf list $name | awk '{print $1}' | grep -v "^\*"; echo "latest"; } | fzf)
  asdf set $name $({asdf list $name | awk '{print $1}' | grep -v "^\*"; echo "latest"; } | fzf)
}

# ZSH Autosuggestion 2024-05-24
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Increase history size
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
