hc attr theme.reset 1
hc set frame_border_active_color $COLOR_CYAN
hc set frame_border_normal_color $COLOR_TERMINAL_BLACK
# hc set frame_bg_normal_color '#ff0000aa'  # only takes effect when frame_bg_transparent is off
# hc set frame_bg_active_color '#ffffff'  # only takes effect when frame_bg_transparent is off
hc set frame_border_width 2
hc set frame_border_inner_width 0
hc set frame_border_inner_color $COLOR_GREEN
hc set show_frame_decorations 'focused_if_multiple'
hc set frame_bg_transparent on
hc set frame_transparent_width 0
hc set frame_gap 8

hc attr theme.title_height 16
hc attr theme.title_when 'multiple_tabs'
hc attr theme.title_font 'Iosevka Term:pixelsize=13'
# hc attr theme.title_font '-*-fixed-medium-r-*-*-13-*-*-*-*-*-*-*'
hc attr theme.title_depth 4  # space below the title's baseline
hc attr theme.title_color $COLOR_FG

hc attr theme.background_color '#ffffff'  # not sure where is the bg color

hc attr theme.border_width $(( 8 + $WIDTH ))
hc attr theme.color $COLOR_DARK3
hc attr theme.inner_color $COLOR_DARK5
hc attr theme.inner_width $WIDTH
hc attr theme.outer_color $COLOR_DARK3
hc attr theme.outer_width $WIDTH

hc attr theme.tab_color $COLOR_BLACK
# hc attr theme.tab_outer_color $COLOR_DARK5
# hc attr theme.tab_outer_width 2
hc attr theme.tab_title_color $COLOR_DARK5

# hc attr theme.active.color $COLOR_TERMINAL_BLACK
hc attr theme.active.outer_width $WIDTH
hc attr theme.active.outer_color $COLOR_GREEN
hc attr theme.active.title_color $COLOR_FG

hc attr theme.floating.outer_width $WIDTH
hc attr theme.floating.outer_color $COLOR_GREEN
hc attr theme.floating.title_color $COLOR_BLACK
hc attr theme.floating.title_when 'always'

hc attr theme.urgent.color $COLOR_MAGENTA
hc attr theme.urgent.outer_width $WIDTH
hc attr theme.urgent.outer_color $COLOR_YELLOW
hc attr theme.urgent.title_color $COLOR_BLACK

# copy inner color to outer_color
# for state in active urgent normal ; do
#     hc substitute C theme.${state}.inner_color \
#         attr theme.${state}.outer_color C
# done

