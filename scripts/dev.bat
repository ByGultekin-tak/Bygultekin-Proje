@echo off
echo 🚀 Starting Elelden Development Environment

REM Check if Docker is running
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Docker is not running. Please start Docker and try again.
    exit /b 1
)

REM Start development databases
echo [INFO] Starting development databases...
docker-compose -f docker-compose.dev.yml up -d

REM Wait for MySQL to be ready
echo [INFO] Waiting for MySQL to be ready...
:wait_mysql
docker exec elelden_mysql_dev mysqladmin ping -h"localhost" --silent >nul 2>&1
if %errorlevel% neq 0 (
    echo|set /p="."
    timeout /t 1 /nobreak >nul
    goto wait_mysql
)
echo.

REM Backend setup
echo [INFO] Setting up backend...
cd backend

REM Create .env file if it doesn't exist
if not exist .env (
    echo [INFO] Creating .env file from template...
    copy .env.example .env
    echo [WARNING] Please update the .env file with your configuration
)

REM Install Go dependencies
echo [INFO] Installing Go dependencies...
go mod download

REM Start backend server
echo [INFO] Starting backend server...
start /b go run cmd\api\main.go

cd ..

REM Frontend setup
echo [INFO] Setting up frontend...
cd frontend

REM Install Node.js dependencies
if not exist node_modules (
    echo [INFO] Installing Node.js dependencies...
    npm install
) else (
    echo [INFO] Node.js dependencies already installed
)

REM Start frontend development server
echo [INFO] Starting frontend development server...
start /b npm run dev

cd ..

echo [INFO] ✅ Development environment started successfully!
echo.
echo [INFO] 📍 Services:
echo [INFO]    • Frontend: http://localhost:3000
echo [INFO]    • Backend:  http://localhost:8080
echo [INFO]    • MySQL:    localhost:3307
echo [INFO]    • Redis:    localhost:6380
echo.
echo [WARNING] Press any key to stop all services
pause >nul

echo [INFO] Stopping services...
docker-compose -f docker-compose.dev.yml down
taskkill /f /im go.exe >nul 2>&1
taskkill /f /im node.exe >nul 2>&1
