#! /bin/bash

# Plan for unpack function
# parse the argument/s
# for each BASENAME.EXTENSION create a directory named BASENAME_EXTENSION
# unzip BASENAME.EXTENSION to BASENAME_EXTENSION
# for each file FOO.json do jq-linux64 . FOO.json > TEMP_FOO.json; mv TEMP_FOO.json FOO.json
# for each file FOO.xml or FOO.svg do cat FOO.svg | xmllint --format - > TEMP_FOO.svg && mv TEMP_FOO.svg FOO.svg (or TEMP_FOO.xml and FOO.xml)

# Plan for pack function
# parse argument/s
# for each BASENAME_EXTENSION cd BASENAME_EXTENSION && zip ../BASENAME.EXTENSION *
