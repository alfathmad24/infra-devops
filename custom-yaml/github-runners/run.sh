#!/bin/bash

# Check if runner is already configured
if [ ! -f .runner ]; then
  ./config.sh --url https://github.com/alfathmad24/nextjs-fe --token ALAQTRORRQ2IIVJCGNWEMSTEQSQ5S
fi

# Run the runner
./run.sh
