#!/bin/bash

echo "🚀 Starting Elelden Development Environment"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    print_error "Docker is not running. Please start Docker and try again."
    exit 1
fi

# Start development databases
print_status "Starting development databases..."
docker-compose -f docker-compose.dev.yml up -d

# Wait for MySQL to be ready
print_status "Waiting for MySQL to be ready..."
until docker exec elelden_mysql_dev mysqladmin ping -h"localhost" --silent; do
    echo -n "."
    sleep 1
done
echo ""

# Backend setup
print_status "Setting up backend..."
cd backend

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    print_status "Creating .env file from template..."
    cp .env.example .env
    print_warning "Please update the .env file with your configuration"
fi

# Install Go dependencies
print_status "Installing Go dependencies..."
go mod download

# Run migrations (if any)
print_status "Running database migrations..."
# go run migrations/migrate.go up

print_status "Starting backend server..."
go run cmd/api/main.go &
BACKEND_PID=$!

cd ..

# Frontend setup
print_status "Setting up frontend..."
cd frontend

# Install Node.js dependencies
if [ ! -d "node_modules" ]; then
    print_status "Installing Node.js dependencies..."
    npm install
else
    print_status "Node.js dependencies already installed"
fi

print_status "Starting frontend development server..."
npm run dev &
FRONTEND_PID=$!

cd ..

print_status "✅ Development environment started successfully!"
echo ""
print_status "📍 Services:"
print_status "   • Frontend: http://localhost:3000"
print_status "   • Backend:  http://localhost:8080"
print_status "   • MySQL:    localhost:3307"
print_status "   • Redis:    localhost:6380"
echo ""
print_warning "Press Ctrl+C to stop all services"

# Wait for Ctrl+C
trap "print_status 'Stopping services...'; kill $BACKEND_PID $FRONTEND_PID 2>/dev/null; docker-compose -f docker-compose.dev.yml down; exit" INT

# Keep script running
wait
