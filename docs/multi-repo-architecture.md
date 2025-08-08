# Multi-Repository Architecture Guide

## Repository Separation Strategy

### 1. Backend Repository: `sahibinden-backend`
**Repository URL**: `https://github.com/ByGultekin-tak/sahibinden-backend`

#### Structure:
```
sahibinden-backend/
├── cmd/
│   └── api/
│       └── main.go
├── internal/
│   ├── api/
│   │   ├── handlers/
│   │   ├── middleware/
│   │   └── routes/
│   ├── domain/
│   │   ├── entities/
│   │   └── services/
│   ├── repository/
│   │   └── mysql/
│   └── config/
├── pkg/
│   ├── auth/
│   └── utils/
├── migrations/
├── docs/
├── docker/
├── .env.example
├── Dockerfile
├── docker-compose.yml
├── go.mod
├── go.sum
└── README.md
```

#### Features:
- ✅ Clean Architecture implementation
- ✅ JWT Authentication system
- ✅ Category-specific models (Emlak, Araç, İkinci El)
- ✅ RESTful API endpoints
- ✅ MySQL database integration
- ✅ Docker support

### 2. Frontend Repository: `sahibinden-frontend`
**Repository URL**: `https://github.com/ByGultekin-tak/sahibinden-frontend`

#### Structure:
```
sahibinden-frontend/
├── src/
│   ├── components/
│   │   ├── ui/
│   │   ├── forms/
│   │   └── layout/
│   ├── pages/
│   │   ├── emlak/
│   │   ├── arac/
│   │   └── ikinci-el/
│   ├── hooks/
│   ├── services/
│   │   └── api/
│   ├── context/
│   ├── types/
│   └── utils/
├── public/
├── package.json
├── vite.config.ts
├── tailwind.config.js
├── tsconfig.json
├── Dockerfile
└── README.md
```

#### Features:
- ✅ React 18 + TypeScript
- ✅ Tailwind CSS responsive design
- ✅ Category-specific components
- ✅ Authentication integration
- ✅ API client with Axios

### 3. Future Repositories

#### Mobile App: `sahibinden-mobile`
- React Native
- iOS & Android support
- Push notifications
- Offline capabilities

#### Admin Panel: `sahibinden-admin`
- React-based admin interface
- User management
- Content moderation
- Analytics dashboard

#### Analytics Service: `sahibinden-analytics`
- Data processing service
- User behavior tracking
- Business intelligence
- Reporting system

## Migration Steps

### Step 1: Create Backend Repository
```bash
# Create new repository
git clone https://github.com/ByGultekin-tak/sahibinden-backend.git
cd sahibinden-backend

# Copy backend files from current repo
cp -r ../Bygultekin-Proje/backend/* .
cp ../Bygultekin-Proje/docker-compose.yml .
cp ../Bygultekin-Proje/docker-compose.dev.yml .

# Update go.mod module path
# Update import paths in all Go files

# Initial commit
git add .
git commit -m "Initial backend setup with Clean Architecture"
git push origin main
```

### Step 2: Create Frontend Repository
```bash
# Create new repository
git clone https://github.com/ByGultekin-tak/sahibinden-frontend.git
cd sahibinden-frontend

# Copy frontend files from current repo
cp -r ../Bygultekin-Proje/frontend/* .

# Update package.json name
# Update API endpoints to point to backend

# Initial commit
git add .
git commit -m "Initial frontend setup with React + TypeScript"
git push origin main
```

### Step 3: Update This Repository
```bash
# Update README to point to separate repositories
# Keep this as documentation and architecture overview
# Remove actual code files, keep only documentation
```

## Development Workflow

### Local Development
```bash
# Terminal 1: Backend
git clone https://github.com/ByGultekin-tak/sahibinden-backend.git
cd sahibinden-backend
go run cmd/api/main.go

# Terminal 2: Frontend  
git clone https://github.com/ByGultekin-tak/sahibinden-frontend.git
cd sahibinden-frontend
npm run dev

# Terminal 3: Database
docker-compose -f docker-compose.dev.yml up -d
```

### Production Deployment
```bash
# Each repository will have its own CI/CD pipeline
# Backend: Deploy to container registry + Kubernetes
# Frontend: Build and deploy to CDN
# Database: Managed MySQL service
```

## Benefits of Multi-Repository Architecture

### ✅ Advantages:
1. **Independent Development**: Teams can work on different components independently
2. **Separate Release Cycles**: Frontend and backend can be released independently
3. **Technology Flexibility**: Each repo can use different tech stacks
4. **Cleaner CI/CD**: Separate build and deployment pipelines
5. **Better Security**: Limited access scope per repository
6. **Scalability**: Different repositories can scale independently

### ⚠️ Considerations:
1. **API Versioning**: Maintain backward compatibility
2. **Cross-Repository Changes**: Coordinate changes that affect multiple repos
3. **Documentation Sync**: Keep documentation updated across repositories
4. **Dependency Management**: Manage shared dependencies carefully

## API Contract Management

### Shared API Types
Create a shared TypeScript definitions package:
```bash
npm create @sahibinden/api-types
```

### API Versioning Strategy
- Use semantic versioning for API
- Maintain backward compatibility
- Deprecation notices for old endpoints
- Clear migration guides

## Monitoring & Observability

### Backend Monitoring
- Health checks endpoint
- Prometheus metrics
- Structured logging
- Error tracking with Sentry

### Frontend Monitoring
- Web Vitals tracking
- Error boundary reporting
- User analytics
- Performance monitoring

## Security Considerations

### Backend Security
- JWT token validation
- Rate limiting
- Input sanitization
- SQL injection prevention
- CORS configuration

### Frontend Security
- XSS prevention
- Content Security Policy
- Secure storage of tokens
- HTTPS enforcement

---

This multi-repository approach will provide better maintainability, scalability, and team collaboration for the Sahibinden Clone project.
