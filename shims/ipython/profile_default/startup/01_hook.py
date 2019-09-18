# pylint: disable-all
# REF: https://gist.github.com/nova77/5403446
# REF: https://gist.github.com/vpontis/46e5d3154cda92ce3e0f


import os
import sys
from importlib.util import find_spec
from common_proc import colors
from IPython.core.magic import register_line_magic, register_line_cell_magic

# System check
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


def _pyplot_imshow(img):
    if find_spec('matplotlib') is None:
        print(colors("ERROR! -- 'matplotlib' not found!", fg='red'))
        return
    else:
        import matplotlib.pyplot as plt

    if find_spec('mamba') is not None:
        from mamba.base import imageMb

        if isinstance(img, imageMb):
            print("imageMb --> PIL")
            from mamba.miscellaneous import Mamba2PIL
            img = Mamba2PIL(img)

    if find_spec('PIL') is not None:
        from PIL import Image
        from PIL.ImageFile import ImageFile

        if isinstance(img, ImageFile) or isinstance(img, Image.Image):
            print("PIL --> ndarray")
            img = cv2.cvtColor(np.array(img), cv2.COLOR_RGB2BGR)

    if not isinstance(img, np.ndarray):

        print(colors(
            "ERROR! -- argument type must be numpy.ndarray, not {type} !".format(
                type=type(img)
            ), fg='red'))
        return

    plt.tick_params(
        labelbottom=False, labelleft=False, labelright=False, labeltop=False,
        bottom=False, left=False, right=False, top=False
    )
    if img.ndim == 2:
        plt.imshow(img, cmap="gray")
    else:
        plt.imshow(cv2.cvtColor(img, cv2.COLOR_BGR2RGB))

    plt.show()


@register_line_cell_magic
def copy(line, cell=None):
    if line and cell:
        cell = '\n'.join((line, cell))

    _copy_to_clipboard(cell or line)


@register_line_magic
def imshow(line):
    img = eval(line)

    if img is None:
        print("UndefinedVariable: {line}".format(
            line=line
        ))
    else:
        _pyplot_imshow(img)


print(
    colors("ADD", attr='bold', fg='white'),
    colors("%copy", attr='bold', fg='green'),
    colors("BUILT-IN MAGGIC COMMAND !", attr='bold', fg='white')
)

print(
    colors("ADD", attr='bold', fg='white'),
    colors("%imshow", attr='bold', fg='green'),
    colors("BUILT-IN MAGGIC COMMAND !", attr='bold', fg='white')
)

# We delete it to avoid name conflicts for automagic to work
del copy, imshow
