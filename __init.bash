#!/bin/sh

echo -e "Initializing git bash environment\033[0;36m"

source $(dirname "${BASH_SOURCE[0]}")/_aliases-init.bash
source $(dirname "${BASH_SOURCE[0]}")/_prompt-init.bash

echo -e '\033[0m\n'