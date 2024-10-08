# Licensed under https://github.com/wpilibsuite/frc-docs-translations/blob/main/license.txt

# BASEDIR is set by <lang>/conf.py
"""
Use "-D language=<LANG>" option to build a localized sphinx document.
For example::
    sphinx-build -D language=ja -b html . _build/html
This conf.py does:
- Specify `locale_dirs` and `gettext_compact`.
- Overrides source directory as 'sphinx/doc/`.
"""
from pathlib import Path
import os

BASEDIR = os.path.dirname(os.path.abspath(__file__))

with open(os.path.join(BASEDIR, "gm0/source/conf.py")) as conf_f:
    exec(conf_f.read(), globals())

locale_dirs = [os.path.join(BASEDIR, "locale/")]
gettext_compact = False

setup_original = setup


def setup(app):
    app.srcdir = Path(os.path.join(BASEDIR, "gm0/source/"))
    app.confdir = app.srcdir

    tags.add("translation")

    setup_original(app)
