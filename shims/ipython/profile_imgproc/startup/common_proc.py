# pylint: disable-all


def colors(s, attr='', fg='default', bg='default'):
    ESC = "\x1b"
    FG = {
        "default": 9, "black": 30, "red": 31, "green": 32, "yellow": 33, "blue": 34,
        "magenta": 35, "cyan": 36, "light gray": 37, "light gray": 90, "light red": 91,
        "light green": 92, "light yellow": 93, "light blue": 94, "light magenta": 95,
        "light cyan": 96, "white": 97
    }
    BG = {
        "default": 49, "black": 40, "red": 41, "green": 42, "yellow": 43, "blue": 44,
        "magenta": 45, "cyan": 46, "light gray": 47, "light gray": 100, "light red": 101,
        "light green": 102, "light yellow": 103, "light blue": 104, "light magenta": 105,
        "light cyan": 106, "white": 107
    }
    ATTR = {'bold': 1, 'dark': 2, 'underline': 4,
            'blink': 5, 'reverse': 7, 'hidden': 8}

    return "{e}[{a};{f};{b}m{s}{e}[m".format(
        e=ESC,
        a=sum([v for k, v in ATTR.items() if k in attr]),
        f=FG[fg],
        b=BG[bg],
        s=s
    )
