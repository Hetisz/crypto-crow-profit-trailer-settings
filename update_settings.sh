#!/bin/bash

DATETIME=`date '+%Y-%m-%d %H:%M:%S'`
DATE=`date +%Y-%m-%d`

rm PT-Files.zip
rm -fr PT\ Files
curl -o PT-Files.zip -L http://jasonappleton.com/Settings &> /dev/null
unzip PT-Files.zip

if [[ -z $(git status -s) || $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]]; then
  git add .
  git commit -m "Updated settings: $DATETIME"
  git push origin :refs/tags/$DATE
  git tag -f $DATE
  git push
  git push --tags
  echo "Updated and pushed tag $DATE. We're all done!"
else
  echo "Nothing changed. Nothing to do."
  exit 1
fi

