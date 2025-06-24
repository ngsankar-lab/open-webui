#!/bin/bash

echo "🔄 Restarting LazyBoy application..."

# Stop any running processes
echo "Stopping current processes..."
pkill -f "npm run dev" 2>/dev/null || true
pkill -f "uvicorn" 2>/dev/null || true

# Build frontend
echo "Building frontend..."
npm run build

# Start backend
echo "Starting backend..."
./backend/start.sh &
BACKEND_PID=$!

# Wait a moment for backend to start
sleep 3

# Start frontend dev server
echo "Starting frontend dev server..."
npm run dev &
FRONTEND_PID=$!

echo ""
echo "✅ LazyBoy is starting up!"
echo "📱 Frontend: http://localhost:5173"
echo "🔧 Backend: http://localhost:8080"
echo ""
echo "Backend PID: $BACKEND_PID"
echo "Frontend PID: $FRONTEND_PID"
echo ""
echo "To stop: pkill -f 'npm run dev' && pkill -f 'uvicorn'"