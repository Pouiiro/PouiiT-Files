# kitty pills tab bar
# Save as something like kitty_pills_tabbar.py and point kitty to it in kitty.conf

import datetime
from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer
from kitty.rgb import to_color
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    Formatter,
    TabBarData,
    as_rgb,
    draw_attributed_string,
)

timer_id = None


def draw_pill(screen: Screen, text: str, fg_rgb, bg_rgb, default_bg_rgb) -> None:
    """
    Draw a filled pill:
       [ space + text + space ] <space>
    fg_rgb and bg_rgb must already be converted via as_rgb(...)
    default_bg_rgb is as_rgb(int(draw_data.default_bg))
    """
    # left rounded edge (edge colored like bg, drawn on default background)
    screen.cursor.fg = bg_rgb
    screen.cursor.bg = default_bg_rgb
    screen.draw("")

    # middle filled part (fg on bg)
    screen.cursor.fg = fg_rgb
    screen.cursor.bg = bg_rgb
    screen.draw(f" {text} ")

    # right rounded edge
    screen.cursor.fg = bg_rgb
    screen.cursor.bg = default_bg_rgb
    screen.draw("")

    # spacing between pills
    screen.draw(" ")


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    global timer_id
    if timer_id is None:
        # update time/date every 2s
        timer_id = add_timer(_redraw_tab_bar, 2.0, True)

    # compute default bg (used for the pill edges)
    default_bg = as_rgb(int(draw_data.default_bg))

    # choose text and colors
    title = tab.title[:max_title_length] if tab.title else ""

    if tab.is_active:
        fg = as_rgb(int(draw_data.active_fg))
        bg = as_rgb(int(draw_data.active_bg))
    else:
        fg = as_rgb(int(draw_data.inactive_fg))
        bg = as_rgb(int(draw_data.inactive_bg))

    # draw the tab as a pill
    draw_pill(screen, title, fg, bg, default_bg)

    # if this was the last tab to be drawn, paint the right-side status
    if is_last:
        draw_right_status(draw_data, screen)

    return screen.cursor.x


def draw_right_status(draw_data: DrawData, screen: Screen) -> None:
    # reset any terminal attributes that might be lingering
    draw_attributed_string(Formatter.reset, screen)

    default_bg = as_rgb(int(draw_data.default_bg))
    inactive_fg_rgb = as_rgb(int(draw_data.inactive_fg))
    inactive_bg_rgb = as_rgb(int(draw_data.inactive_bg))

    cells = create_cells()

    # If there isn't enough room, drop oldest cells (leftmost)
    def pill_width_for_text(s: str) -> int:
        # approximate width in characters:
        # left edge (1) + " " (1) + text (len) + " " (1) + right edge (1) + trailing space (1)
        return len(s) + 5

    while True:
        if not cells:
            return
        total = sum(pill_width_for_text((c.get("icon", "") or "") + c["text"]) for c in cells)
        padding = screen.columns - screen.cursor.x - total
        if padding >= 0:
            break
        cells = cells[1:]

    # pad between tabs and status pills
    if padding:
        screen.draw(" " * padding)

    for c in cells:
        # prefer a color specified in the cell, otherwise use inactive_fg
        if c.get("color"):
            try:
                color_int = to_color(c.get("color"))
                fg_rgb = as_rgb(int(color_int))
            except Exception:
                fg_rgb = inactive_fg_rgb
        else:
            fg_rgb = inactive_fg_rgb

        bg_rgb = inactive_bg_rgb
        text = f"{(c.get('icon') or '')}{c['text']}"
        draw_pill(screen, text, fg_rgb, bg_rgb, default_bg)


def create_cells():
    return [c for c in [get_date(), get_time()] if c is not None]


def get_time():
    now = datetime.datetime.now().strftime("%H:%M")
    return {"icon": " ", "color": "#669bbc", "text": now}


def get_date():
    today = datetime.date.today()
    if today.weekday() < 5:
        return {"icon": "󰃵 ", "color": "#2a9d8f", "text": today.strftime("%b %e")}
    else:
        return {"icon": "󰧓 ", "color": "#f2e8cf", "text": today.strftime("%b %e")}


def _redraw_tab_bar(timer_id):
    for tm in get_boss().all_tab_managers:
        tm.mark_tab_bar_dirty()
