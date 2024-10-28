ZSH_THEME_GIT_PROMPT_SUFFIX="] "

nix_shell_prompt() {
	[[ -v IN_NIX_SHELL ]] && echo "nix shell "
}

PROMPT='$(nix_shell_prompt)$(git_super_status)'
PROMPT+='%F{green}%n@%m%F{white}:%F{blue}%~%F{white}$ '

bindkey '^R' history-incremental-search-backward

[[ $- == *i* ]] && [ -z "$TMUX" ] && exec tmux
