if status is-interactive
    # Commands to run in interactive sessions can go here

    set -gx PATH $HOME/.tmuxifier/bin $PATH
    eval (tmuxifier init - fish)

end


starship init fish | source
