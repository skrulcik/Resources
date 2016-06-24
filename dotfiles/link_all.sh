#!/bin/bash

THIS_FOLDER=$(pwd)

for i in .[^.]*
do
    if [ -L ~/$i ]
    then
        echo ~/$i exists, skipped.
    else
        echo "Linking $i..."
        ln -s "$THIS_FOLDER/$i" ~/$i
    fi
done

