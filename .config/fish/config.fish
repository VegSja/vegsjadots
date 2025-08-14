# PATHs and Editor
set -x EDITOR nvim

# Aliases
alias ls="eza --icons"
alias rr="yazi"
alias hf='eval (history | fzf | sed "s/ *[0-9]* *//")'
alias zed="open -a /Applications/Zed.app -n"
alias lzd="lazydocker"
alias lzg="lazygit"
alias nixupdate="darwin-rebuild switch --flake ~/.config/nix#air"

# Function
function nf
    set file (fzf --preview='bat {}')
    if test -n "$file"
        nvim "$file"
    end
end

# Tools
starship init fish | source
zoxide init fish | source
#
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/anaconda3/bin/conda
    eval /opt/anaconda3/bin/conda "shell.fish" hook $argv | source
else
    if test -f "/opt/anaconda3/etc/fish/conf.d/conda.fish"
        . "/opt/anaconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH /opt/anaconda3/bin $PATH
    end
end
# <<< conda initialize <<<
