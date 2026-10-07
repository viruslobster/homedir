# config.nu
#
# Installed by:
# version = "0.116.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

$env.config.show_banner = false
$env.config.edit_mode = 'vi'
$env.config.buffer_editor = 'nvim'

# Simple two-line prompt.
$env.PROMPT_COMMAND = {||
    let host = (sys host).hostname | split row '.' | first
    let path = $env.PWD | str replace $env.HOME '~'
    $"($env.USER)@($host) ($path)\n"
}
$env.PROMPT_COMMAND_RIGHT = {|| '' }
$env.PROMPT_INDICATOR = {|| '❯ ' }
$env.PROMPT_INDICATOR_VI_INSERT = {|| $"(ansi green_bold)[I](ansi reset) ❯ " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| $"(ansi red_bold)[N](ansi reset) ❯ " }

# Keep completion-menu redraws aligned with the Vi prompt indicators.
$env.config.menus = ($env.config.menus | each {|menu|
    if $menu.name in [completion_menu ide_completion_menu] {
        $menu | upsert marker $"(ansi green_bold)[I](ansi reset) ❯ "
    } else {
        $menu
    }
})

# Workman Vi bindings
$env.config.keybindings ++= [
    { name: workman_left, modifier: none, keycode: char_y, mode: vi_normal, event: { edit: moveleft } }
    { name: workman_right, modifier: none, keycode: char_o, mode: vi_normal, event: { edit: moveright } }
    { name: workman_up, modifier: none, keycode: char_e, mode: vi_normal, event: { send: up } }
    { name: workman_down, modifier: none, keycode: char_n, mode: vi_normal, event: { send: down } }
    { name: normal_mode, modifier: control, keycode: char_n, mode: vi_insert, event: { send: switchmode, mode: vi_normal } }
    { name: accept_autosuggestion, modifier: alt, keycode: char_n, mode: vi_insert, event: { send: historyhintcomplete } }
    { name: edit_command_buffer, modifier: alt, keycode: char_e, mode: [vi_normal vi_insert], event: { send: openeditor } }
]

# Delegate external command completions to Fish.
let fish_completer = {|place|
    fish --command $"complete '--do-complete=($place.command
        | str replace --all "'" "\\'"
        | str join ' ')'"
    | from tsv --flexible --noheaders --no-infer
    | rename value description
}

$env.config.completions.external.completer = $fish_completer

alias vim = nvim
alias sl = ls
alias zed = /Applications/Zed.app/Contents/MacOS/cli

# fnm and direnv update the environment when changing directories.
$env.config.hooks.env_change.PWD = ($env.config.hooks.env_change.PWD? | default [])
$env.config.hooks.env_change.PWD ++= [
    {||
        if not (which fnm | is-empty) {
            if ([.node-version .nvmrc package.json] | any {|file| $file | path exists }) {
                ^fnm use --silent-if-unchanged
            }
        }
    }
    {||
        if not (which direnv | is-empty) {
            ^direnv export json | from json | default {} | load-env
        }
    }
]
