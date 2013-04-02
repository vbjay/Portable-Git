#!/bin/sh

cd / &&
git submodule update --init --recursive share/src/GitExtensions &&
cd share/src/GitExtensions &&
git remote add upstream https://github.com/gitextensions/gitextensions.git &&
git checkout master &&
git fetch upstream


