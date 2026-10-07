# env.nu
#
# Installed by:
# version = "0.116.1"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.

$env.JAVA_HOME = "/Applications/Android Studio.app/Contents/jbr/Contents/Home"
$env.ANDROID_HOME = $"($env.HOME)/Library/Android/sdk"
$env.ANDROID_SDK_ROOT = $env.ANDROID_HOME
$env.EDITOR = "nvim"
$env.PF_EXPERIMENTAL_VM = "1"
$env.XDG_CONFIG_HOME = $"($env.HOME)/.config"

$env.PATH = ($env.PATH | prepend [
    $"($env.JAVA_HOME)/bin"
    $"($env.ANDROID_HOME)/platform-tools"
    $"($env.ANDROID_HOME)/cmdline-tools/latest/bin"
    $"($env.ANDROID_HOME)/emulator"
    $"($env.HOME)/bin"
    $"($env.HOME)/go/bin"
    $"($env.HOME)/.cargo/bin"
    $"($env.HOME)/.local/bin"
    "/opt/homebrew/share/google-cloud-sdk/bin"
    "/opt/homebrew/opt/libpq/bin"
])

if not (which fnm | is-empty) {
    ^fnm env --json | from json | load-env
    $env.PATH = ($env.PATH | prepend $"($env.FNM_MULTISHELL_PATH)/bin")
}
