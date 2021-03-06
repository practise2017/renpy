#!/bin/sh

set -e

SPHINX="$(dirname $(python -c "import os;print(os.path.realpath('$0'))"))"

cd "$SPHINX"

# Delete .pyo files, which could not include docstrings.
find ../renpy -name \*.pyo -delete

../renpy.sh .

rm -Rf ../doc-web/_images || true
rm -Rf ../doc/_images || true

sphinx-build -E -a source ../doc-web &
RENPY_NO_FIGURES=1 sphinx-build -E -a source ../doc 2>/dev/null
wait
python checks.py

