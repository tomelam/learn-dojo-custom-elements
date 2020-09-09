#!/usr/bin/env bash 

echo "Checking tools for building a Dojo widget ..."

echo "Checking availability of Node ..."
if [[ -z "$(node --version)" ]] ; then
  echo "Install Node first. It might be best if you get it directly from"
  echo "https://nodejs.org/en/ ."
  exit 1
else
  echo "On Windows & Mac, manually check that you are using the LTS version:"
  echo "  node -v"
  echo "Get it at https://nodejs.org (https://nodejs.org/en/download/)."
  echo "As of September 8, 2020, the LTS version is v12.18.3 ."
  echo "Better use NVM (https://github.com/nvm-sh/nvm) to install and use it."
fi

if ! npm list -g @dojo/cli > /dev/null ; then
  echo "@dojo/cli not installed globally. Please install it first:"
  echo "  npm i -g @dojo/cli"
  exit 2
fi

if ! npm list -g @dojo/cli-create-widget > /dev/null ; then
  echo "@dojo/cli-create-widget not installed globally."
  echo "Please install it first:"
  echo "  npm i -g @dojo/cli-create-widget"
  echo "A similar notification would have occurred anyway if you had"
  echo "  straightaway run 'dojo create widget'."
  exit 3
fi

if ! npm list -g typescript > /dev/null ; then
  echo "typescript not installed globally. Please install it first:"
  echo "  npm i -g typescript"
  exit 3
fi

echo "The prerequisites are installed for building an app or widget."
