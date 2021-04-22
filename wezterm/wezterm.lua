local wezterm = require 'wezterm';

return {
    font = wezterm.font_with_fallback({
        "MonoLisa",
        "Fira Code",
    }),
    font_size = 16.0,
    keys = {
        { key="p", mods="CMD",  action="ShowTabNavigator" },
        { key="q", mods="CMD",  action="QuitApplication" },
        { key="l", mods="CMD",  action="ActivateLastTab" },
        { key="m", mods="CMD",  action="ShowLauncher" },

        -- { key="h", mods="CMD", action=wezterm.action{ ActivatePaneDirection="Left" } },
        -- { key="j", mods="CMD", action=wezterm.action{ ActivatePaneDirection="Down" } },
        -- { key="k", mods="CMD", action=wezterm.action{ ActivatePaneDirection="Up" } },
        -- { key="l", mods="CMD", action=wezterm.action{ ActivatePaneDirection="Right" } },

        { key="h", mods="CTRL", action=wezterm.action{ SplitVertical={ domain="CurrentPaneDomain" } } },
        { key="v", mods="CTRL", action=wezterm.action{ SplitHorizontal={ domain="CurrentPaneDomain" } } },
    },
    ssh_domains = {
        {
            name = "home.server",
            remote_address = "192.168.0.48",
            username = "jared",
        }
    },
    colors = {
        foreground = "#cbccc6",
        background = "#1f2430",

        cursor_bg = "#ffcc66",
        cursor_fg = "#191e2a",
        cursor_border = "#ffcc66",

        selection_bg = "#33415e",
        selection_fg = "#fad07b";

        ansi = {"#191e2a", "#ed8274", "#a6cc70", "#fad07b", "#6dcbfa", "#cfbafa", "#90e1c6", "#c7c7c7"},
        brights = {"#686868", "#f28779", "#bae67e", "#ffd580", "#73d0ff", "#d4bfff", "#95e6cb", "#ffffff"},

        tab_bar = {
            background = "#1f2430",
            active_tab = {
                bg_color = "#1f2430",
                fg_color = "#cbccc6",
                intensity = "Bold",
                italic = true,
            },
            inactive_tab = {
                bg_color = "#1f2430",
                fg_color = "#707a8c",
          },
      },
    }
}
