#!/bin/bash

# Check for required environment variables
if [ -z "$RUNNER_NAME" ] || [ -z "$GITHUB_PAT" ] || [ -z "$GITHUB_OWNER" ] || [ -z "$GITHUB_REPO" ]; then
    echo "One or more required environment variables are missing. Aborting."
    exit 1
fi

# Configure the runner
/actions-runner/config.sh --url https://github.com/$GITHUB_OWNER/$GITHUB_REPO --token $GITHUB_PAT --runnergroup $RUNNER_GROUP --labels $RUNNER_LABELS --name $RUNNER_NAME --unattended

# Start the runner
exec /actions-runner/entrypoint.sh