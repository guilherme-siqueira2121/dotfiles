# ============================================================================
# ENVIRONMENT
# ============================================================================

set -gx EDITOR nvim
set -gx ELECTRON_OZONE_PLATFORM_HINT wayland
set -gx GDK_BACKEND wayland
set -gx QT_QPA_PLATFORM wayland
set -gx XCURSOR_SIZE 16
set -gx PNPM_HOME "$HOME/.local/share/pnpm"

set -U fish_user_paths $HOME/dotfiles/bin $HOME/.local/bin $PNPM_HOME $fish_user_paths

# ============================================================================
# SHELL
# ============================================================================

set fish_greeting
set fish_cursor_default beam

# ============================================================================
# ALIASES
# ============================================================================

alias ll='eza --icons --group-directories-first -l'
alias f='ff'

# ============================================================================
# FUNCTIONS
# ============================================================================

# ls com eza
function ls
    eza --icons --group-directories-first $argv
end

# Yazi com troca de diretório
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and test -n "$cwd"; and test "$cwd" != "$PWD"
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# Fuzzy finder
function ff
    set search_dir (test -n "$argv[1]"; and echo "$argv[1]"; or echo ".")

    set code_extensions \
        txt md markdown sh bash fish \
        js jsx ts tsx json jsonc \
        py rb go rs lua vim \
        html htm css scss \
        yaml yml toml ini conf \
        c cpp h hpp

    set selected (find $search_dir -type f -o -type d 2>/dev/null | \
        fzf --height=40% \
            --layout=reverse \
            --border \
            --preview='if test -d {}; eza --icons {}; else; head -50 {}; end' \
            --preview-window=right:50%:wrap \
            --header="Enter: abrir | Tab: preview")

    test -z "$selected" && return 0

    if test -d "$selected"
        cd "$selected"
    else if test -f "$selected"
        set ext (string split -r -m1 . "$selected")[2]
        if contains (string lower "$ext") $code_extensions
            nvim "$selected"
        else
            xdg-open "$selected" 2>/dev/null &
        end
    end
end

# ============================================================================
# KEYBINDINGS
# ============================================================================

bind \cf 'ff; commandline -f repaint'

# ============================================================================
# PROMPT
# ============================================================================

function fish_prompt
    set -l last_status $status
    set -l cyan (set_color cyan)
    set -l green (set_color green)
    set -l blue (set_color blue)
    set -l red (set_color red)
    set -l magenta (set_color magenta)
    set -l normal (set_color normal)
    set -l bold (set_color --bold)

    echo -n $cyan$bold"󰣇 "$USER$normal
    echo -n "@"
    echo -n $green(prompt_hostname)$normal
    echo -n " "
    echo -n $blue(prompt_pwd)$normal

    if test $last_status -ne 0
        echo -n $red" [$last_status]"$normal
    end

    echo -n $magenta" > "$normal
end
```

---

### `config/kitty/kitty.conf`
```
# Fonte
font_family      JetBrains Mono Nerd Font
bold_font        auto
italic_font      auto
bold_italic_font auto
font_size        12.0

# Cursor
cursor_shape beam
cursor_blink_interval 0.6

# Janela
window_padding_width 10
background_opacity 1.0
remember_window_size yes
initial_window_width 120
initial_window_height 32

# Performance
repaint_delay 10
input_delay 1
sync_to_monitor yes
enable_audio_bell no

# Scrollback
scrollback_lines 10000

# Shell
shell /bin/fish

# Atalhos
map ctrl+shift+v paste_from_clipboard
map ctrl+shift+c copy_to_clipboard
map ctrl+shift+t new_tab
map ctrl+shift+w close_tab
map ctrl+shift+right next_tab
map ctrl+shift+left previous_tab
map ctrl+shift+enter new_window
map ctrl+shift+j next_window
map ctrl+shift+k previous_window

term xterm-kitty

# Tema Gruvbox Dark
foreground #d4be98
background #000000
background_opacity 1

cursor #d5c4a1
selection_foreground #fbf1c7
selection_background #3a3a3a

tab_bar_style powerline
active_tab_background #2c2c2c
active_tab_foreground #ebdbb2
inactive_tab_background #1a1a1a
inactive_tab_foreground #665c54

active_border_color #fabd2f
inactive_border_color #3c3836

color0  #0f0f0f
color1  #aa2222
color2  #78823c
color3  #a67c21
color4  #3a5a78
color5  #8e5d78
color6  #5c7f6a
color7  #928374
color8  #3c3836
color9  #bb4444
color10 #9bbc46
color11 #cfa935
color12 #689cb5
color13 #b07090
color14 #78b29c
color15 #ebdbb2