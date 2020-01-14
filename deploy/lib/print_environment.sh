#!/bin/bash

set -e

while [ $# -gt 0 ]
do
  key="$1"

  case $key in
    --running-tag)
      RUNNING_TAG="$2"
      shift
      shift
    ;;
    *)
      echo "Unknown option $1\n"
      shift
      shift
  esac
done

RED=`tput setaf 1`
YELLOW=`tput setaf 3`
RESET_COLOR=`tput sgr0`

if [ "$RUNNING_TAG" = "staging" ]; then
  COLOR=$YELLOW
else
  COLOR=$RED
fi

echo "${COLOR}Running in $RUNNING_TAG environment...${RESET_COLOR}"
