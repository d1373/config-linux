#===============================================================================
# History
#===============================================================================
HISTFILE="~/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS   # No duplicate entries
setopt HIST_IGNORE_SPACE      # Ignore commands starting with space
setopt SHARE_HISTORY          # Share history across all open terminals
setopt INC_APPEND_HISTORY     # Write to history file immediately, not on exit
#===============================================================================
# Zinit
#===============================================================================
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
#===============================================================================
# Environment Variables
#===============================================================================
export MANPAGER="sh -c 'col -bx | nvim -R -c \"set ft=man\" -'"
export EDITOR="nvim"
export VISUAL="nvim"
export BAT_THEME="ansi"
setopt correct
eval "$(zoxide init zsh)"
export GPG_TTY=$(tty)
# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/dhyey/.lmstudio/bin"
# End of LM Studio CLI section
export PATH="$HOME/.local/share/scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"
# .zshrc
autoload -U promptinit; promptinit
prompt pure
# pnpm
export PNPM_HOME="/Users/dhyey/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
eval "$(fnm env --use-on-cd --shell zsh)"

autoload -Uz compinit
compinit

#===============================================================================
# Key Bindings and Cursor Shape (Vi Mode)
#===============================================================================
bindkey -v
export KEYTIMEOUT=1

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd || $1 == 'block' ]]; then
    echo -ne '\e[1 q'
  else
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

function zle-line-init {
  zle -K viins
  echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q'
preexec() { echo -ne '\e[5 q'; }

zstyle ':completion:*' menu select
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line
### End of Key Bindings and Cursor Shape (Vi Mode)

#===============================================================================
# Plugins
#===============================================================================

zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found
zinit snippet OMZP::extract       # Universal extract command
### End of Plugins
#===============================================================================
# settings for plugins
#===============================================================================
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # Case insensitive
zstyle ':completion:*' menu select                       # Menu selection
zstyle ':completion:*' rehash true                       # Auto rehash commands
zstyle ':completion::complete:*' gain-privileges 1       # Privilege completion
# FZF tab completion styling
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --color=always --icons $realpath 2>/dev/null || ls --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --color=always --icons $realpath 2>/dev/null || ls --color=always $realpath'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'
### End of settings for plugins
#===============================================================================
# Aliases
#===============================================================================
alias ..='cd ..'
alias ...='cd ../..'
alias cat='bat'
alias sudo='sudo-rs'
alias sudoedit='sudo-rs -e'
alias vi='nvim'
alias v='nvim'
alias grep='rg'
alias ll='eza -la --icons --header --group-directories-first --git'
alias l='eza -l --icons --header --git --group-directories-first'
alias ls='eza --icons --oneline --group-directories-first'
alias :q='exit'
alias m='file --mime-type'
alias o='xdg-open'
# Tmux Aliases
alias tks='tmux kill-server'
alias lg='lazygit'
alias ta='~/.local/share/scripts/sss.sh'
alias zednb="launchctl setenv LOCAL_NOTEBOOK_DEV 1"

# Miscellaneous
alias n='pnpm'
alias mb="~/.local/share/scripts/brew-search.sh"
alias mbr="~/.local/share/scripts/brew-remove.sh"
alias di="~/.local/share/scripts/dnf-install"
alias dr="~/.local/share/scripts/dnf-remove"
