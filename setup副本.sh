#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASENAME=`basename "$DIR"`

if [ "$BASENAME" = "Resources" ]; then
    DIR=`dirname "$DIR"`
    DIR=`dirname "$DIR"`
    DIR=`dirname "$DIR"`
    export CALL_BY_CONTAINER=APP
fi

if [ ! "$2" == "" ]; then
    DIR=$2
    export CALL_BY_CONTAINER=PKG
fi;

VERSION=`cat $DIR/VERSION`

if [ "$CALL_BY_CONTAINER" == "PKG" ]; then
    LOG_FILENAME="/tmp/quick-cocos2d-x-${VERSION}-setup.log"
fi

if [ "$CALL_BY_CONTAINER" == "PKG" ]; then
    echo "quick-cocos2d-x-${VERSION} setup log" > "$LOG_FILENAME"
    echo "================================" >> "$LOG_FILENAME"
fi
FBX_SDK_ROOT="$DIR"

# set Xcode
defaults write com.apple.dt.Xcode IDEApplicationwideBuildSettings -dict-add FBX_SDK_ROOT "$FBX_SDK_ROOT"
defaults write com.apple.dt.Xcode IDESourceTreeDisplayNames -dict-add FBX_SDK_ROOT FBX_SDK_ROOT
IDEApplicationwideBuildSettings=`defaults read com.apple.dt.Xcode IDEApplicationwideBuildSettings`
IDESourceTreeDisplayNames=`defaults read com.apple.dt.Xcode IDESourceTreeDisplayNames`

echo "> Xcode settings updated." 