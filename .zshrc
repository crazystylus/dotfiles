# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ZSH History Settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

fpath=("$HOME/.zprompts" "$fpath[@]")
autoload -Uz compinit promptinit
compinit
promptinit

# Load the theme
prompt powerline10k

# Integrating Zoxide
eval "$(zoxide init zsh)"

# ls replacement with exa
alias ls="exa"
alias l="exa -h"
alias la="exa -ha"
alias ll="exa -lh"
alias lla="exa -lha"

# Replace vim with nvim
alias vim="nvim"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# replacing cd with Zoxide
function cd {
  __zoxide_z  "$@" && ls -F
}
