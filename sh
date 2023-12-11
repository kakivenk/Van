#!/bin/bash

# Define port and address
PORT=5555
ADDRESS=0.0.0.0

# Start netcat server
nc -l $PORT $ADDRESS

# Handle incoming messages
while read message; do
  # Strip leading and trailing spaces
  message=$(echo "$message" | sed 's/^[[:space:]]*//g' | sed 's/[[:space:]]*$//g')

  # Broadcast message to all connected clients
  echo "> $message" | nc -w 0 $ADDRESS $PORT
done





#!/bin/bash

# Define server address and port
SERVER_ADDRESS=127.0.0.1
SERVER_PORT=5555

# Connect to server
nc -w 0 $SERVER_ADDRESS $SERVER_PORT

# Send messages
while read message; do
  # Strip leading and trailing spaces
  message=$(echo "$message" | sed 's/^[[:space:]]*//g' | sed 's/[[:space:]]*$//g')

  # Check for empty message
  if [[ -z "$message" ]]; then
    continue
  fi

  # Send message to server
  echo "$message" | nc -w 0 $SERVER_ADDRESS $SERVER_PORT
done
