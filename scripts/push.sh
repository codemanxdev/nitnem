#!/bin/bash

# Merge develop changes to master and push them upstream.

echo "Checking current branch"
git status


git checkout master
git merge develop
git push
git checkout develop