#!/bin/bash
# This script is run after the dev container is created. Use it finish
# initialising dev environmnet, ie. tasks which effects are not version
# controlled.


# Unofficial Bash Strict Mode
set -euo pipefail
IFS=$'\n\t'

echo "Creating app user in Postgres..."
.devcontainer/scripts/create_postgres_user.sh
echo "Done."

echo "Running mix setup..."
mix setup
echo "Done."
