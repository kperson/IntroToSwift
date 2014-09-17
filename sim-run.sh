#!/bin/bash
#
# Build and iPhone Simulator Helper Script
# Shazron Abdullah 2011
#
# WARN: - if your .xcodeproj name is not the same as your .app name,
#		    this won't work without modifications
#		- you must run this script in where your .xcodeproj file is

PROJECTNAME=$1
CONFIGURATION=$2
LOGFILE=$3

function help
{
	echo "Usage: $0 <projectname> [configuration] [errorlog] [outlog]"
	echo "<projectname>		name of your .xcodeproj file (and your .app as well)"
	echo "[configuration]	(optional) Debug or Release, defaults to Debug"
	echo "[errorlog]			(optional) the log file to write to. defaults to stderror.log"
	echo "[outlog]			  (optional) the log file to write to. defaults to outlog.log"
}

# check first argument
if [ -z "$PROJECTNAME" ] ; then
	help
	exit 1
fi

# check second argument, default to "Debug"
if [ -z "$CONFIGURATION" ] ; then
	CONFIGURATION=Debug
fi

# check third argument, default to "stderror.log"
if [ -z "$ERRORLOG" ] ; then
	ERRORLOG=stderror.log
fi

# check four argument, default to "stdout.log"
if [ -z "$OUTLOG" ] ; then
	OUTLOG=stdout.log
fi

SDK=iphonesimulator8.0

touch -cm www
rm $ERRORLOG
rm $OUTLOG
xcodebuild -configuration $CONFIGURATION -sdk $SDK -project $PROJECTNAME.xcodeproj
ios-sim launch build/$CONFIGURATION-iphonesimulator/$PROJECTNAME.app --stderr $ERRORLOG --stdout $OUTLOG --sdk 8.0 --family ipad --exit
osascript -e "tell application \"iOS Simulator\" to activate"
#tail -f $ERRORLOG


#"/Applications/Xcode.app/Contents/Developer/Applications/iOS Simulator.app/Contents/MacOS/iOS Simulator" build/$CONFIGURATION-iphonesimulator/$PROJECTNAME.app
