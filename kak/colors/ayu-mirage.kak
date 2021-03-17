evaluate-commands %sh{
    common_accent="rgb:ffcc66"
    common_bg="rgb:1f2430"
    common_dark_bg="rgb:191e2a"
    common_fg="rgb:cbccc6"
    common_ui="rgb:707a8c"
    syntax_tag="rgb:5ccfe6"
    syntax_func="rgb:ffd580"
    syntax_entity="rgb:73d0ff"
    syntax_string="rgb:bae67e"
    syntax_regexp="rgb:95e6cb"
    syntax_markup="rgb:f28779"
    syntax_keyword="rgb:ffa759"
    syntax_special="rgb:ffe6b3"
    syntax_comment="rgb:5c6773"
    syntax_constant="rgb:d4bfff"
    syntax_operator="rgb:f29e74"
    syntax_error="rgb:ff3333"
    ui_line="rgb:191e2a"
    ui_panel_bg="rgb:232834"
    ui_panel_shadow="rgb:141925"
    ui_panel_border="rgb:101521"
    ui_gutter_normal="rgb:707a8c"
    ui_gutter_active="rgb:707a8c"
    ui_selection_bg="rgb:34455a"
    ui_selection_inactive="rgb:2d3b4d"
    ui_selection_border="rgb:3c526a"
    ui_guide_active="rgb:707a8c"
    ui_guide_normal="rgb:707a8c"
    vcs_added="rgb:a6cc70"
    vcs_modified="rgb:77a8d9"
    vcs_removed="rgb:f27983"

    echo "
        # then we map them to code
        face global value ${syntax_constant}
        face global type ${syntax_entity}
        face global variable ${syntax_regexp}
        face global module ${syntax_special}
        face global identifier ${syntax_regexp}
        face global function ${syntax_func}
        face global string ${syntax_string}
        face global keyword ${syntax_keyword}
        face global operator ${syntax_operator}
        face global attribute ${syntax_tag}
        face global comment ${syntax_comment}
        face global meta ${syntax_markup}
        face global builtin default+b

        # and markup
        face global title ${syntax_tag}
        face global header ${syntax_entity}
        face global bold ${syntax_error}+b
        face global italic ${syntax_func}+i
        face global mono ${syntax_string}
        face global block ${syntax_keyword}
        face global link ${syntax_constant}+u
        face global bullet ${syntax_operator}
        face global list ${syntax_markup}

        # and built in faces
        face global Default ${common_fg},${common_bg}
        face global PrimarySelection ${common_fg},${ui_selection_bg}+fg@Default
        face global SecondarySelection  ${common_fg},${ui_selection_inactive}+fg@Default

        face global PrimaryCursor ${common_fg},${common_accent}+fg
        face global SecondaryCursor ${common_fg},${ui_guide_active}+fg

        face global PrimaryCursorEol ${common_fg},${ui_guide_normal}+Bfg
        face global SecondaryCursorEol ${common_fg},${ui_guide_normal}+fg

        face global LineNumbers ${common_fg},${ui_line}
        face global LineNumberCursor ${common_accent},${ui_line}

        face global MenuForeground ${common_fg},${ui_selection_bg}
        face global MenuBackground ${common_fg},${ui_selection_inactive}

        face global MenuInfo ${common_fg}
        face global Information ${common_fg},${ui_panel_bg}
        face global Error ${syntax_error}+f
        face global StatusLine ${vcs_removed},${common_dark_bg}
        face global StatusLineMode ${vcs_added},${common_dark_bg}+b
        face global StatusLineInfo ${vcs_modified},${common_dark_bg}
        face global StatusLineValue ${vcs_modified},${common_dark_bg}
        face global StatusCursor ${common_fg},${common_dark_bg}
        face global Prompt ${ui_panel_border},${vcs_added}
        face global MatchingChar default,${ui_panel_shadow}
        face global BufferPadding ${common_fg},${common_bg}
        face global Whitespace ${ui_line}+f
    "
}
