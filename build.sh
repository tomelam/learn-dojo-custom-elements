#!/usr/bin/env bash 

# See https://dojo.io/learn/custom-elements/introduction

echo "Building an example Dojo widget as a custom element ..."

if [[ ! -d learn-dojo-custom-elements ]] ; then
  echo "Run ./create.sh first."
  exit 1
fi

cd learn-dojo-custom-elements

dojo build widget
