# massivebird's ranger colorscheme based on
# balanceiskey/vim-framer-syntax
from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *

# custom colors
black=16
blue=39
gray=102
green=36
lightblue=153
lightpink=219
orange=209
pink=204
purple=141
red=168
white=231
yellow=221

class ColorScheme(ColorScheme):

    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        elif context.in_browser:
            if context.selected:
                attr = reverse
            else:
                attr = normal
            if context.empty or context.error:
                fg = black
                bg = red
            if context.border:
                fg = white
            if context.image:
                fg = purple
            if context.video:
                fg = purple
            if context.audio:
                fg = green
            if context.document:
                fg = white
            if context.container:
                attr |= bold
                fg = red
            if context.directory:
                fg = blue
            elif context.executable and not \
                any((context.media, context.container,
                     context.fifo, context.socket)):
                attr |= bold
                fg = 2
            if context.socket:
                fg = lightblue
                attr |= bold
            if context.fifo or context.device:
                fg = lightblue
                if context.device:
                    attr |= bold
            if context.link:
                fg = context.good and lightblue or red
            if context.bad:
                fg = 0
                bg = red
            if context.tag_marker and not context.selected:
                attr |= bold
                fg = red
            if not context.selected and (context.cut or context.copied):
                attr = reverse
            if context.main_column:
                if context.selected:
                    attr |= bold
                if context.marked:
                    attr |= bold
                    fg = gray
            if context.badinfo:
                if attr & reverse:
                    bg = red
                else:
                    fg = white

        elif context.in_titlebar:
            attr |= bold
            if context.hostname:
                fg = context.bad and red or white
            elif context.directory:
                fg = white
            elif context.tab:
                if context.good:
                    bg = 2

        elif context.in_statusbar:
            if context.permissions:
                if context.good:
                    fg = blue
                    bg = 0
                elif context.bad:
                    fg = red
            if context.marked:
                attr |= bold | reverse
                fg = red
            if context.message:
                if context.bad:
                    attr |= bold
                    fg = pink
            if context.loaded:
                bg = red


        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            if context.title:
                fg = blue

            if context.selected:
                attr |= reverse

            if context.loaded:
                if context.selected:
                    fg = red
                else:
                    bg = red

        return fg, bg, attr

