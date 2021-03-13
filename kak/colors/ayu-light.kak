evaluate-commands %sh{
    common_accent="rgb:ff9940"
    common_bg="rgb:fafafa"
    common_fg="rgb:6c7680"
    common_ui="rgb:959da6"
    
    syntax_tag="rgb:55b4d4"
    syntax_func="rgb:f2ae49"
    syntax_entity="rgb:399ee6"
    syntax_string="rgb:86b300"
    syntax_regexp="rgb:4cbf99"
    syntax_markup="rgb:f07171"
    syntax_keyword="rgb:fa8d3e"
    syntax_special="rgb:e6ba7e"
    syntax_comment="rgb:abb0b6"
    syntax_constant="rgb:a37acc"
    syntax_operator="rgb:ed9366"
    syntax_error="rgb:f51818"
    
    ui_line="rgb:959da6"
    ui_panel_bg="rgb:ffffff"
    ui_panel_shadow="rgb:566069"
    ui_panel_border="rgb:f0f0f0"
    ui_gutter_normal="rgb:959da6"
    ui_gutter_active="rgb:959da6"
    ui_selection_bg="rgb:edf0f5"
    ui_selection_inactive="rgb:f2f4f7"
    ui_selection_border="rgb:e5ebf2"
    ui_guide_active="rgb:959da6"
    ui_guide_normal="rgb:959da6"
    
    vcs_added="rgb:99bf4d"
    vcs_modified="rgb:709ecc"
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
