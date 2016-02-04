#!/bin/bash

# Make sure config is available
while [ ! -f /home/config.yaml ]; do
  echo "Waiting for config file"
  sleep 5
done

# Quick check to see if goofys has mounted/started.
while [ ! -d /home/bucket/storage ] || ! ps aux | grep -q [g]oofys; do
  echo "Storage directory or goofys not available"
  echo "Goofys probably hasn't mounted or started yet."
  sleep 5
done

/home/node_modules/sinopia/bin/sinopia --config /home/config.yaml

