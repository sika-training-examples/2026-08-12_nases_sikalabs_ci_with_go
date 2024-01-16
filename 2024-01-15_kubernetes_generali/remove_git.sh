#!/bin/sh

# Remove .git folder from all subfolders
find . -name ".git" -exec rm -rf {} \;
