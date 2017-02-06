#!/bin/sh

MYABSPATH=$(readlink -f "$0")
PATCHBASE=$(dirname "$MYABSPATH")
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
	git am "$PATCHBASE/$PATCHNAME"/*
	# CMD_OUTPUT=$(git am -3 "$PATCHBASE/$PATCHNAME"/*)
	# echo -e $CMD_OUTPUT\n\n

	# if [[ $CMD_OUTPUT =~ échoué.|error.|fail. ]]; then
	# 	git am --abort
	# 	echo Ran into an error
	# else
	# 	echo Patch applied !
	# fi

	cd "$PATCHBASE"
done