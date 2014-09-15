#!/bin/bash

# Entry point for workflow

export WF_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export WF_TASK=$1
export WF_COMMAND=$2
export WF_ENV=$3

source $WF_DIR/config.sh
source $WF_DIR/functions/functions.sh

validate_input_params

out=$(check_github)
if [ $? -gt 1 ]; then
	echo $out
	echo "Add your private key ssh-add [path to pk]."
	exit 1
fi

cd $WF_PROJECT_ROOT
#TODO if is missing - clone it

source $WF_DIR/commands/${WF_COMMAND}.sh

print_msg - line
if [ $? -eq 0 ]; then
	print_msg "BUILD SUCCESS"
else
	print_msg "BUILD FAILURE"
	print_msg $? error
fi
print_msg - line