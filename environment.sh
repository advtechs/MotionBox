#!/bin/sh
set -e

#--------------------------------------------------------------------------------------------------
# Settings
#--------------------------------------------------------------------------------------------------

qt="qt5"

#--------------------------------------------------------------------------------------------------
# Syntax
#--------------------------------------------------------------------------------------------------

if [ $# != 1 ] || [ $1 != "qt4" -a $1 != "qt5" ]; then

    echo "Usage: environment <qt4 | qt5>"

    exit 1
fi

#--------------------------------------------------------------------------------------------------
# Replacements
#--------------------------------------------------------------------------------------------------

expression='s/qt=\"'"$qt"'"/qt=\"'"$1"'"/g'

sed -i $expression environment.sh

sed -i $expression configure.sh
sed -i $expression build.sh
sed -i $expression deploy.sh

sed -i $expression content/generate.sh