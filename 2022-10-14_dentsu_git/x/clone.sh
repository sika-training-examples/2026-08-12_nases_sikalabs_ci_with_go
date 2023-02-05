#!/bin/sh

TEMPLATE=git@github.com:dentsu-creative-cz/demo-template.git

NAME=$1

if [ -z "$NAME" ]; then
  echo "Usage: $0 project-name"
  exit 1
fi

if [ -d "$NAME" ]; then
  echo "Directory $NAME already exists"
  exit 1
fi

NEW=git@github.com:dentsu-creative-cz/demo-project-$NAME.git

mkdir $NAME
cd $NAME
git init
git remote add origin $NEW
git remote add template $TEMPLATE
git fetch --all
git pull origin master
