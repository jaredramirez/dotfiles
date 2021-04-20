local wezterm = require 'wezterm';

return {
    font = wezterm.font("MonoLisa"),
    font_size = 15.0,
    keys = {
        { key="p", mods="CMD", action="ShowTabNavigator" },
        { key="q", mods="CMD", action="QuitApplication" },
        { key="l", mods="CMD", action="ActivateLastTab" },
    }
}
