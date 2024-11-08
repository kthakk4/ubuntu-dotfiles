# Set up default directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# Set default editor
export EDITOR=nvim
export VISUAL=nvim

# Enable colors
autoload -U colors && colors

# Custom Prompt - inspired by https://arjanvandergaag.nl/blog/customize-zsh-prompt-with-vcs-info.html
autoload -Uz vcs_info #vcs_info is where zsh store version control stuff 
zstyle ':vcs_info:*' check-for-changes true # checks if changes in directory
zstyle ':vcs_info:*' formats '(%F{cyan}%s:%f%F{yellow}%b:%F{blue}%m%F{red}%u%F{green}%c%f) ' #s=git, b=branch, m=stashed, u=unstaged, c=staged
precmd () { vcs_info }
setopt prompt_subst #runs the prompt afeter every command
RPROMPT='${vcs_info_msg_0_}' #right prompt
PROMPT='%F{red}[REMOTE]%f %~ %F{112}>%f ' #left prompt n=username, m=host %~=directory

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/conda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/conda/etc/profile.d/conda.sh" ]; then
        . "/opt/conda/etc/profile.d/conda.sh"
    else
        export PATH="/opt/conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.cache/zsh/history

# Basic auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # include hidden files

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# custom alias
alias c=clear
alias ls="ls -lha"
alias zshconfig="nvim $HOME/.zshrc"
alias nvimconfig="nvim $XDG_CONFIG_HOME/nvim/init.lua"
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME' #alias for managing dotfiles
alias ga='git add'
alias gs='git status'
alias gpu='git push -u'

# various plugins (should come last)
source <(fzf --zsh)
conda activate default #activate conda environment named default
source /usr//share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

