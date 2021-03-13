evaluate-commands %sh{
    common_accent="rgb:e6b450"
    common_bg="rgb:0a0e14"
    common_fg="rgb:b3b1ad"
    common_ui="rgb:3d424d"
    syntax_tag="rgb:39bae6"
    syntax_func="rgb:ffb454"
    syntax_entity="rgb:59c2ff"
    syntax_string="rgb:c2d94c"
    syntax_regexp="rgb:95e6cb"
    syntax_markup="rgb:f07178"
    syntax_keyword="rgb:ff8f40"
    syntax_special="rgb:e6b673"
    syntax_comment="rgb:626a73"
    syntax_constant="rgb:ffee99"
    syntax_operator="rgb:f29668"
    syntax_error="rgb:ff3333"
    ui_line="rgb:01060e"
    ui_panel_bg="rgb:0d1016"
    ui_panel_shadow="rgb:00010a"
    ui_panel_border="rgb:000000"
    ui_gutter_normal="rgb:3d424d"
    ui_gutter_active="rgb:3d424d"
    ui_selection_bg="rgb:273747"
    ui_selection_inactive="rgb:1f2c39"
    ui_selection_border="rgb:304357"
    ui_guide_active="rgb:3d424d"
    ui_guide_normal="rgb:3d424d"
    vcs_added="rgb:91b362"
    vcs_modified="rgb:6994bf"
    vcs_removed="rgb:d96c75"

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
        face global StatusLine ${vcs_removed},${ui_panel_border}
        face global StatusLineMode ${vcs_added},${ui_panel_border}+b
        face global StatusLineInfo ${vcs_modified},${ui_panel_border}
        face global StatusLineValue ${vcs_modified},${ui_panel_border}
        face global StatusCursor ${common_fg},${common_accent}
        face global Prompt ${ui_panel_border},${vcs_added}
        face global MatchingChar default,${ui_panel_shadow}
        face global BufferPadding default,${ui_guide_normal}
        face global Whitespace ${ui_line}+f
    "
}
