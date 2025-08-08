# Elelden - Multi-Repository Architecture

A modern, scalable marketplace platform inspired by second-hand and classified ads platforms, built with **separate repositories** for better maintainability and scalability.

## 🏗️ Repository Structure

This project follows a **multi-repository architecture** with separate repos for each component:

### 📦 Active Repositories:
- **🔧 Backend API**: [elelden-backend](https://github.com/ByGultekin-tak/elelden-backend) - Go REST API with Clean Architecture
- **🌐 Frontend Web**: [elelden-frontend](https://github.com/ByGultekin-tak/elelden-frontend) - React TypeScript SPA  

### 🚀 Future Repositories:
- **📱 Mobile App**: `elelden-mobile` - React Native (planned)
- **🔧 Admin Panel**: `elelden-admin` - Admin management interface (planned)
- **📊 Analytics**: `elelden-analytics` - Data analytics service (planned)

### 🏢 Current Repository Status
This repository served as the initial monorepo setup and has been successfully split into separate repositories. 
Each component now has its own dedicated repository for better development workflow.

## 🎯 Core Features by Category

### 🏠 Emlak (Real Estate)
- Property listings (apartments, houses, offices, land)
- Advanced filtering (room count, m2, floor, age, location)
- Interactive maps integration
- Virtual tour support
- Mortgage calculator

### 🚗 Araç (Vehicles) 
- Car, motorcycle, commercial vehicle listings
- Detailed vehicle specifications (brand, model, year, mileage)
- Vehicle history reports
- Inspection reports
- Insurance integration

### 🛍️ İkinci El (Second Hand)
- Electronics, clothing, home goods
- Condition-based categorization
- Warranty information
- Brand and model specifications
- Size and material details

## 🔧 Technology Stack

### Backend (Go)
- **Framework**: Gin (HTTP router)
- **ORM**: GORM with MySQL
- **Authentication**: JWT tokens
- **Architecture**: Clean Architecture principles
- **Caching**: Redis
- **File Storage**: AWS S3 compatible
- **Documentation**: Swagger/OpenAPI

### Frontend (React + TypeScript)
- **Framework**: React 18 with TypeScript
- **Styling**: Tailwind CSS
- **Routing**: React Router v6
- **State**: Context API + React Query
- **Forms**: React Hook Form with Zod
- **Build**: Vite

### Infrastructure
- **Containerization**: Docker & Docker Compose
- **Database**: MySQL 8.0
- **Cache**: Redis
- **Load Balancer**: Nginx (production)
- **Monitoring**: Prometheus + Grafana (future)

## 🚀 Quick Start

### Prerequisites
- Go 1.21+
- Node.js 18+
- Docker & Docker Compose
- MySQL 8.0+

### 1. Clone and Setup Backend
```bash
git clone https://github.com/ByGultekin-tak/sahibinden-backend.git
cd sahibinden-backend
cp .env.example .env
go mod download
go run cmd/api/main.go
```

### 2. Clone and Setup Frontend
```bash
git clone https://github.com/ByGultekin-tak/sahibinden-frontend.git
cd sahibinden-frontend
npm install
npm run dev
```

### 3. Docker Development Environment
```bash
# Start databases
docker-compose -f docker-compose.dev.yml up -d

# Use provided scripts
./scripts/dev.sh    # Linux/Mac
./scripts/dev.bat   # Windows
```

## 📂 Repository Migration Plan

### Phase 1: Backend Separation ✅
- [x] Go backend with Clean Architecture
- [x] JWT authentication system
- [x] Category-specific models (Emlak, Araç, İkinci El)
- [x] RESTful API design
- [x] Docker configuration

### Phase 2: Frontend Separation (Next)
- [ ] React TypeScript frontend
- [ ] Responsive design with Tailwind
- [ ] Category-specific forms and views
- [ ] Authentication integration
- [ ] API client implementation

### Phase 3: Advanced Features
- [ ] Real-time messaging
- [ ] Payment integration
- [ ] Image processing service
- [ ] Search service (Elasticsearch)
- [ ] Notification service

## 🗂️ Category-Specific Features

Each category has specialized fields and business logic:

### 🏠 Emlak Details
```json
{
  "property_type": "konut|is_yeri|arsa",
  "room_count": "1+1|2+1|3+1|...",
  "area": 120.5,
  "floor": 3,
  "total_floors": 8,
  "building_age": 5,
  "furnished": true,
  "features": ["balkon", "asansör", "otopark"]
}
```

### 🚗 Araç Details  
```json
{
  "brand": "Toyota",
  "model": "Corolla",
  "year": 2020,
  "mileage": 45000,
  "fuel_type": "hybrid",
  "transmission": "automatic",
  "condition": "excellent"
}
```

### �️ İkinci El Details
```json
{
  "brand": "Apple",
  "model": "iPhone 13",
  "condition": "like_new",
  "warranty_status": "active",
  "age": 6
}
```

## � Authentication & Authorization

- **JWT-based authentication**
- **Role-based access control** (user, admin, moderator)
- **Email verification**
- **Password reset functionality**
- **Social login integration** (future)

## 📊 API Documentation

- **Base URL**: `http://localhost:8080/api/v1`
- **Authentication**: Bearer token in Authorization header
- **Documentation**: Available at `/docs` endpoint
- **Postman Collection**: Available in `/docs` folder

## 🔄 Development Workflow

1. **Feature branches** for new developments
2. **Pull request reviews** before merging
3. **Automated testing** (unit, integration)
4. **Docker-based development** environment
5. **CI/CD pipeline** with GitHub Actions

## 📝 License

This project is licensed under the MIT License.

---

**Next Steps**: Template integration and separate repository creation for frontend and backend.