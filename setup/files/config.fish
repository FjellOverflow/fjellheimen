set fish_greeting

fish_add_path $HOME/.local/bin

starship init fish | source

if type -q mise
    mise activate fish | source
end

if type -q direnv
    direnv hook fish | source
end

alias cat="bat"
alias l="ls -alh"
alias la="ls -lAh"
alias ll="ls -l"
