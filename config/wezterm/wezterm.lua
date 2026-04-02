local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- 🎨 FONT CONFIGURATION
config.font = wezterm.font_with_fallback({
	"JetBrains Mono Nerd Font",
	"Cascadia Code NF",
	"Droid Sans Mono Nerd Font",
	"monospace",
})
config.font_size = 12.0
config.line_height = 1.2
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }

config.font_rules = {
	{
		intensity = "Bold",
		font = wezterm.font("JetBrains Mono Nerd Font", { weight = "Bold" }),
	},
	{
		italic = true,
		font = wezterm.font("Cascadia Code", { italic = true }),
	},
}

-- 🚀 PERFORMANCE (igual Kitty)
config.max_fps = 120
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.enable_wayland = true
config.animation_fps = 60

-- 🖼️ WINDOW - Minimalista como Kitty
config.window_padding = {
	left = 8,
	right = 8,
	top = 8,
	bottom = 8,
}
config.window_background_opacity = 1.0  -- Opaco como Kitty
config.text_background_opacity = 1.0
config.window_decorations = "NONE"
config.window_close_confirmation = "NeverPrompt"
config.hide_tab_bar_if_only_one_tab = false  -- Sempre mostrar

-- 🎯 CURSOR - Beam style como Kitty
config.default_cursor_style = "SteadyBar"  -- Beam vertical
config.cursor_thickness = 2.0
config.cursor_blink_rate = 600
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- 🎨 DRACULA THEME - Dark puro como Kitty
config.colors = {
	-- Base colors
	foreground = "#f8f8f2",
		background = "#000000",  -- Preto puro como Kitty

		-- Cursor
		cursor_bg = "#ff79c6",
		cursor_fg = "#000000",
		cursor_border = "#ff79c6",

		-- Selection
		selection_fg = "#000000",
		selection_bg = "#ff79c6",

		-- Scrollbar e splits
		scrollbar_thumb = "#44475a",
		split = "#44475a",

		-- ANSI Colors - Dracula vibrant
		ansi = {
			"#21222c",  -- black
			"#ff5555",  -- red
			"#50fa7b",  -- green
			"#f1fa8c",  -- yellow
			"#bd93f9",  -- blue
			"#ff79c6",  -- magenta
			"#8be9fd",  -- cyan
			"#f8f8f2",  -- white
		},

		brights = {
			"#6272a4",  -- bright black
			"#ff6e6e",  -- bright red
			"#69ff94",  -- bright green
			"#ffffa5",  -- bright yellow
			"#d6acff",  -- bright blue
			"#ff92df",  -- bright magenta
			"#a4ffff",  -- bright cyan
			"#ffffff",  -- bright white
		},

		-- Indexed colors (extras)
		indexed = {
			[16] = "#ffb86c",  -- orange
			[17] = "#ff79c6",  -- pink
		},

		-- Tab bar - Powerline style
		tab_bar = {
			background = "#000000",
			active_tab = {
				bg_color = "#282a36",
				fg_color = "#ff79c6",
				intensity = "Bold",
			},
			inactive_tab = {
				bg_color = "#1a1a1a",
				fg_color = "#6272a4",
			},
			inactive_tab_hover = {
				bg_color = "#282a36",
				fg_color = "#8be9fd",
			},
			new_tab = {
				bg_color = "#1a1a1a",
				fg_color = "#6272a4",
			},
			new_tab_hover = {
				bg_color = "#282a36",
				fg_color = "#ff79c6",
			},
		},
}

-- 📊 TAB BAR - Powerline com Arch icon
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.tab_max_width = 32

-- Formatar tabs com Arch icon
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
local background = "#1a1a1a"
local foreground = "#6272a4"

if tab.is_active then
	background = "#282a36"
	foreground = "#ff79c6"
		elseif hover then
			background = "#282a36"
			foreground = "#8be9fd"
				end

				local title = tab.active_pane.title
				-- Limitar tamanho do título
				if #title > 20 then
					title = wezterm.truncate_right(title, 20) .. "…"
					end

					return {
						{ Background = { Color = background } },
						{ Foreground = { Color = foreground } },
						{ Text = " " .. (tab.tab_index + 1) .. ": " .. title .. " " },
					}
					end)

-- 🖥️ WINDOW TITLE - Com Arch icon
wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
local zoomed = ""
if tab.active_pane.is_zoomed then
	zoomed = "[Z] "
	end

	local index = ""
	if #tabs > 1 then
		index = string.format("[%d/%d] ", tab.tab_index + 1, #tabs)
		end

		return "󰣇 Arch Linux " .. zoomed .. index .. tab.active_pane.title
		end)

-- ⌨️ KEY BINDINGS - Igual Kitty
config.keys = {
	-- Clipboard
	{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("ClipboardAndPrimarySelection") },
	{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },

	-- Font size
	{ key = "=", mods = "CTRL|SHIFT", action = wezterm.action.IncreaseFontSize },
	{ key = "-", mods = "CTRL|SHIFT", action = wezterm.action.DecreaseFontSize },
	{ key = "0", mods = "CTRL|SHIFT", action = wezterm.action.ResetFontSize },

	-- Tab management (como Kitty)
	{ key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "LeftArrow", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ShowLauncher },

	-- Tabs por número
	{ key = "1", mods = "ALT", action = wezterm.action.ActivateTab(0) },
	{ key = "2", mods = "ALT", action = wezterm.action.ActivateTab(1) },
	{ key = "3", mods = "ALT", action = wezterm.action.ActivateTab(2) },
	{ key = "4", mods = "ALT", action = wezterm.action.ActivateTab(3) },
	{ key = "5", mods = "ALT", action = wezterm.action.ActivateTab(4) },

	-- Window/Pane management
	{ key = "Enter", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "/", mods = "CTRL", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "j", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Next") },
	{ key = "k", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Prev") },
	{ key = "z", mods = "CTRL|SHIFT", action = wezterm.action.TogglePaneZoomState },

	-- Search
	{ key = "f", mods = "CTRL|SHIFT", action = wezterm.action.Search({ CaseInSensitiveString = "" }) },

	-- Quick select
	{ key = " ", mods = "CTRL|SHIFT", action = wezterm.action.QuickSelect },

	-- Reload
	{ key = "r", mods = "CTRL|SHIFT", action = wezterm.action.ReloadConfiguration },
}

-- 🔗 HYPERLINKS
config.hyperlink_rules = {
	{
		regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
		format = "$0",
	},
}

-- 🐚 SHELL
config.set_environment_variables = {
	TERM = "wezterm",
	COLORTERM = "truecolor",
}
config.default_prog = { "/bin/fish", "-l" }

-- 💡 SETTINGS
config.automatically_reload_config = true
config.check_for_updates = true
config.audible_bell = "Disabled"  -- Sem som como Kitty
config.scrollback_lines = 10000
config.enable_scroll_bar = false
config.warn_about_missing_glyphs = false

-- Adicione estas linhas ao seu wezterm.lua

-- 🎯 CURSOR - Animação suave como Kitty
config.default_cursor_style = "SteadyBar"
config.cursor_thickness = 2.0
config.cursor_blink_rate = 500  -- Mais rápido
config.cursor_blink_ease_in = "Linear"  -- Sem easing
config.cursor_blink_ease_out = "Linear"  -- Sem easing

-- Animação suave de movimento
config.animation_fps = 120  -- FPS alto
config.max_fps = 120

-- 📏 WINDOW SIZE
config.initial_cols = 120
config.initial_rows = 30

-- 🎆 VISUAL ENHANCEMENTS
config.bold_brightens_ansi_colors = true
config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.6,
}

-- Underline style
config.underline_thickness = 2
config.underline_position = -2

return config
