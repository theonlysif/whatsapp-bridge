#!/bin/bash

# Start WhatsApp MCP Server
# This script starts the WhatsApp bridge in the background and then starts the MCP server

set -e

echo "🚀 Starting WhatsApp MCP Server..."

# Set default environment variables
export MCP_HOST=${MCP_HOST:-"0.0.0.0"}
export MCP_PORT=${MCP_PORT:-"3000"}
export BRIDGE_URL=${BRIDGE_URL:-"http://localhost:8080"}
export BRIDGE_PORT=${BRIDGE_PORT:-"8080"}

echo "📱 Starting WhatsApp bridge on port $BRIDGE_PORT..."
# Start the Go WhatsApp bridge in the background
./main &
BRIDGE_PID=$!

# Give the bridge time to start up
sleep 5

echo "🔗 Starting MCP server on $MCP_HOST:$MCP_PORT..."
echo "🌉 Bridge URL: $BRIDGE_URL"

# Change to MCP server directory and start it
cd whatsapp-mcp-server
python main.py &
MCP_PID=$!

echo "✅ WhatsApp MCP Server started successfully!"
echo "📋 MCP Server: http://$MCP_HOST:$MCP_PORT"
echo "🏥 Health check: http://$MCP_HOST:$MCP_PORT/health"

# Function to cleanup background processes
cleanup() {
    echo "🛑 Shutting down services..."
    if [[ $BRIDGE_PID ]]; then
        kill $BRIDGE_PID 2>/dev/null || true
    fi
    if [[ $MCP_PID ]]; then
        kill $MCP_PID 2>/dev/null || true
    fi
    exit 0
}

# Set up signal handlers
trap cleanup SIGINT SIGTERM

# Wait for both processes
wait $BRIDGE_PID $MCP_PID