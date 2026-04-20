if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    set EDITOR nvim
    
    fish_vi_key_bindings
    # remap some bindings for workman keyboard
    bind y backward-char
    bind o forward-char
    bind e up-or-search #history-token-search-backward
    bind n down-or-search #history-token-search-forward
    bind -M insert \cn 'set fish_bind_mode default; commandline -f repaint'
    bind -M insert \en accept-autosuggestion

    fish_add_path /home/viruslobster/bin
    fish_add_path /home/viruslobster/go/bin
    fish_add_path /home/viruslobster/.cargo/bin
    fish_add_path /home/viruslobster/.local/kitty.app/bin
    fish_add_path /home/viruslobster/.local/bin
    export PATH="$PATH:::"
    alias vim=nvim
    alias sl=ls
end
