# API Documentation

## Base URL
- Development: `http://localhost:8080/api/v1`
- Production: `https://your-domain.com/api/v1`

## Authentication

Most endpoints require authentication via JWT token in the Authorization header:
```
Authorization: Bearer <your-jwt-token>
```

## Endpoints

### Authentication

#### POST /auth/register
Register a new user account.

**Request Body:**
```json
{
  "email": "user@example.com",
  "username": "username",
  "password": "password",
  "firstName": "John",
  "lastName": "Doe",
  "phone": "+905551234567"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "user": {
      "id": 1,
      "email": "user@example.com",
      "username": "username",
      "firstName": "John",
      "lastName": "Doe"
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

#### POST /auth/login
Login with existing credentials.

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "password"
}
```

### Users

#### GET /users/profile
Get current user profile (requires authentication).

#### PUT /users/profile
Update current user profile (requires authentication).

### Categories

#### GET /categories
Get all categories.

**Query Parameters:**
- `parent_id` (optional): Filter by parent category
- `active` (optional): Filter by active status

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "name": "Emlak",
      "slug": "emlak",
      "description": "Gayrimenkul ilanları",
      "icon": "home",
      "isActive": true,
      "children": [...]
    }
  ]
}
```

### Listings

#### GET /listings
Get all listings with filtering and pagination.

**Query Parameters:**
- `page` (default: 1): Page number
- `limit` (default: 20): Items per page
- `category_id`: Filter by category
- `location`: Filter by location
- `min_price`: Minimum price filter
- `max_price`: Maximum price filter
- `search`: Search in title and description
- `sort`: Sort by (price_asc, price_desc, date_asc, date_desc)

#### POST /listings
Create a new listing (requires authentication).

**Request Body:**
```json
{
  "title": "2+1 Apartment for Sale",
  "description": "Beautiful apartment in city center...",
  "price": 850000,
  "currency": "TRY",
  "location": "Istanbul, Beyoğlu",
  "categoryId": 1
}
```

#### GET /listings/:id
Get listing details by ID.

#### PUT /listings/:id
Update listing (requires authentication and ownership).

#### DELETE /listings/:id
Delete listing (requires authentication and ownership).

### Favorites

#### GET /favorites
Get user's favorite listings (requires authentication).

#### POST /favorites
Add listing to favorites (requires authentication).

**Request Body:**
```json
{
  "listingId": 123
}
```

#### DELETE /favorites/:id
Remove listing from favorites (requires authentication).

## Error Responses

All endpoints may return error responses in the following format:

```json
{
  "success": false,
  "message": "Error description",
  "errors": [
    {
      "field": "email",
      "message": "Email is required"
    }
  ]
}
```

### HTTP Status Codes

- `200 OK`: Success
- `201 Created`: Resource created successfully
- `400 Bad Request`: Invalid request data
- `401 Unauthorized`: Authentication required
- `403 Forbidden`: Insufficient permissions
- `404 Not Found`: Resource not found
- `422 Unprocessable Entity`: Validation errors
- `500 Internal Server Error`: Server error

## Rate Limiting

API endpoints are rate limited:
- Anonymous users: 100 requests per hour
- Authenticated users: 1000 requests per hour

Rate limit headers are included in responses:
```
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 999
X-RateLimit-Reset: 1640995200
```
