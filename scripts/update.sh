#!/bin/sh
# update transifex pot and local po files

set -ex

LANG_TO_PULL=${1:-'ro_RO,pt,ja_JP,fr_CA,zh_CN,es_MX'}
LANG_MAP='ro_RO: ro, ja_JP: ja, fr_CA: fr, es_MX: es'
MAINPROJECT=gm0
ORGANIZATION=gamemanual0

# Set working directory to repo root
cd `dirname $0`/..

# Create POT Files
sphinx-build -T -b gettext $MAINPROJECT/source locale/pot

# Update .tx/config
rm .tx/config
sphinx-intl create-txconfig
echo "lang_map = ${LANG_MAP}" >> .tx/config
sphinx-intl update-txconfig-resources -p locale/pot -d locale --transifex-project-name $MAINPROJECT --transifex-organization-name $ORGANIZATION

# Push and pull from Transifex. It is important to push then pull!
# If you pull then push, the PO files will contain out of date strings.
if [ "$CI" = true ]
then
    tx push --source --skip
fi
tx pull -l $LANG_TO_PULL -t --mode onlyreviewed --use-git-timestamps
