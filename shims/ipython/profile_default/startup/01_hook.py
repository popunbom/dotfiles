# pylint: disable-all
# REF: https://gist.github.com/nova77/5403446
# REF: https://gist.github.com/vpontis/46e5d3154cda92ce3e0f


import os
import sys
from common_proc import colors
from IPython.core.magic import register_line_cell_magic
if sys.platform == 'darwin':
    import subprocess
elif sys.platform.startswith('linux'):
    from subprocess import Popen, PIPE
else:
    raise ImportError("Clip magic only works on osx or linux!")


def _copy_to_clipboard(arg):
    ENV = os.environ
    arg = str(globals().get(arg) or arg)

    if sys.platform == 'darwin':
        process = subprocess.Popen(
            'pbcopy', env={'LANG': ENV['LANG']}, stdin=subprocess.PIPE)
        process.communicate(arg.encode('utf-8'))
    elif sys.platform.startswith('linux'):
        p = Popen(['xsel', '-pi'], stdin=PIPE)
        p.communicate(input=arg)

    print(colors(' -- Copied to clipboard!', attr='bold', fg='green'))


@register_line_cell_magic
def copy(line, cell=None):
    if line and cell:
        cell = '\n'.join((line, cell))

    _copy_to_clipboard(cell or line)


print(colors("ADD", attr='bold', fg='white'), colors("%copy", attr='bold',
                                                     fg='green'), colors("BUILT-IN MAGGIC COMMAND !", attr='bold', fg='white'))

# We delete it to avoid name conflicts for automagic to work
del copy
