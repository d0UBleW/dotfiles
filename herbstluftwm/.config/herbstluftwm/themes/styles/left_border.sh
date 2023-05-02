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

hc attr theme.title_height 0
hc attr theme.title_when 'multiple_tabs'
hc attr theme.title_font 'Iosevka Term:pixelsize=14'
# hc attr theme.title_font '-*-fixed-medium-r-*-*-13-*-*-*-*-*-*-*'
hc attr theme.title_depth 4  # space below the title's baseline
hc attr theme.title_color $COLOR_TERMINAL_BLACK

hc attr theme.background_color '#00000000'  # background when resizing

hc attr theme.border_width 2
hc attr theme.color $COLOR_TERMINAL_BLACK
hc attr theme.inner_color $COLOR_TERMINAL_BLACK
hc attr theme.inner_width 0
hc attr theme.outer_color $COLOR_TERMINAL_BLACK
hc attr theme.outer_width 0
hc attr theme.padding_left 12

hc attr theme.tab_color $COLOR_BLACK
hc attr theme.tab_title_color $COLOR_DARK5

hc attr theme.active.inner_width 10
hc attr theme.active.inner_color $COLOR_TERMINAL_BLACK
hc attr theme.active.color $COLOR_BLUE
hc attr theme.active.title_color $COLOR_FG

hc attr theme.floating.inner_width 12
hc attr theme.floating.inner_color $COLOR_TERMINAL_BLACK
hc attr theme.floating.title_color $COLOR_TERMINAL_BLACK
hc attr theme.floating.active.color $COLOR_MAGENTA
hc attr theme.floating.title_when 'always'

# hc attr theme.urgent.color $COLOR_MAGENTA
hc attr theme.urgent.inner_width 10
hc attr theme.urgent.inner_color $COLOR_TERMINAL_BLACK
hc attr theme.urgent.color $COLOR_YELLOW
hc attr theme.urgent.title_color $COLOR_BLACK

# copy inner color to outer_color
# for state in active urgent normal ; do
#     hc substitute C theme.${state}.inner_color \
#         attr theme.${state}.outer_color C
# done
