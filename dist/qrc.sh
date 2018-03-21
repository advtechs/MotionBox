#!/bin/sh

#--------------------------------------------------------------------------------------------------
# Settings
#--------------------------------------------------------------------------------------------------

Sky="../../Sky"

SkyComponents="$Sky/src/SkyComponents"

#--------------------------------------------------------------------------------------------------

content="../content"

#--------------------------------------------------------------------------------------------------
# Syntax
#--------------------------------------------------------------------------------------------------

if [ $# != 1 -a $# != 2 ] \
   || \
   [ $1 != "qt4" -a $1 != "qt5" -a $1 != "clean" ] \
   || \
   [ $# = 2 -a "$2" != "deploy" ]; then

    echo "Usage: qrc <qt4 | qt5 | clean> [deploy]"

    exit 1
fi

#--------------------------------------------------------------------------------------------------
# Clean
#--------------------------------------------------------------------------------------------------

if [ $1 = "clean" ] || [ "$2" = "deploy" ]; then

    echo "CLEANING"

    rm -f qrc/*.qml

    rm -rf qrc/pictures
    rm -rf qrc/text

    if [ $1 = "clean" ]; then

        exit 0
    fi

    echo ""
fi

#--------------------------------------------------------------------------------------------------
# QML
#--------------------------------------------------------------------------------------------------

echo "COPYING QML"

cp "$SkyComponents"/*.qml qrc

cp "$content"/*.qml qrc

#--------------------------------------------------------------------------------------------------
# Content
#--------------------------------------------------------------------------------------------------

if [ "$2" = "deploy" ]; then

    echo "COPYING pictures"

    cp -r "$SkyComponents"/pictures qrc

    cp -r "$content"/pictures qrc

    echo "COPYING text"

    cp -r "$content"/text qrc
fi

echo ""

#--------------------------------------------------------------------------------------------------
# Deployer
#--------------------------------------------------------------------------------------------------

if [ $1 = "qt4" ]; then

    "$Sky"/deploy/deployer qrc 1.1 MotionBox.qrc
else
    "$Sky"/deploy/deployer qrc 2.7 MotionBox.qrc
fi
