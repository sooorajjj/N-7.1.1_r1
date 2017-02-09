#!/bin/sh

PATCHBASE=$(pwd -L)
AOSPBASE=$(readlink -f "$PATCHBASE/../")

for i in $(find "$PATCHBASE"/* -type d); do
	PATCHNAME=$(basename "$i")
	PATCHTARGET=$PATCHNAME
	for i in $(seq 4); do
		PATCHTARGET=$(echo $PATCHTARGET | sed 's/_/\//')
		if [ -d "$AOSPBASE/$PATCHTARGET" ]; then break; fi
	done
	echo applying $PATCHNAME to $PATCHTARGET
	cd "$AOSPBASE/$PATCHTARGET"
	git am -3 "$PATCHBASE/$PATCHNAME"/*

	cd "$PATCHBASE"
done