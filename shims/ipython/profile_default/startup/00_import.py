# pylint: disable-all

from common_proc import colors
import importlib


IMPORT_LIBS = [
    # ( name, alias )
    ('cv2', None),
    ('numpy', 'np'),
    ('os', None),
    ('sys', None),
]


print("-------- {0} Import libs --------".format(
    colors("START:", attr="bold", fg="blue")
))

for lib_name, alias in IMPORT_LIBS:
    if importlib.util.find_spec(lib_name):
        if alias:
            exec("import %s as %s" % (lib_name, alias))
            print("{0:10s} -- {1} as {2}".format(
                lib_name,
                colors("Loaded !", attr="bold", fg="green"),
                colors(alias, attr="bold", fg="white")
            ))
        else:
            exec("import %s" % lib_name)
            print("{0:10s} -- {1}".format(
                lib_name,
                colors("Loaded !", attr="bold", fg="green")
            ))


print("--------- {0} Import libs ---------".format(
    colors("END:", attr="bold", fg="blue")
))

del lib_name, alias, IMPORT_LIBS
