# CreatorOps ERP - Architecture Overview

## System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                      Client Layer (React)                    │
│  (Dashboard, Forms, Reports, Dark/Light Mode)               │
└─────────────────────────┬───────────────────────────────────┘
                          │ HTTP/REST API
                          ↓
┌─────────────────────────────────────────────────────────────┐
│                   API Layer (Express.js)                      │
│  (Authentication, Validation, Business Logic)               │
│  Routes: Auth, Category, Employee, Attendance, Salary, etc  │
└─────────────────────────┬───────────────────────────────────┘
                          │ Database Queries
                          ↓
┌─────────────────────────────────────────────────────────────┐
│                  Data Layer (PostgreSQL)                      │
│  (Normalized Schema, Indexes, Views, Triggers)              │
└─────────────────────────────────────────────────────────────┘
```

## Technology Stack

### Frontend
- **Framework**: React 18 with TypeScript
- **UI Framework**: Tailwind CSS
- **State Management**: Zustand
- **Charts**: Recharts
- **HTTP Client**: Axios
- **Icons**: React Icons
- **Date Handling**: date-fns

### Backend
- **Runtime**: Node.js
- **Framework**: Express.js with TypeScript
- **Database**: PostgreSQL
- **Authentication**: JWT (JSON Web Tokens)
- **Validation**: Joi
- **Security**: Helmet, CORS, Rate Limiting
- **Logging**: Morgan

### Database
- **DBMS**: PostgreSQL 13+
- **ORM**: Raw SQL with pg client
- **Schema**: Fully normalized with relationships
- **Views**: For auto-calculations
- **Triggers**: For audit logging

## Key Features

### Auto-Calculations
- Per-day salary calculation
- Monthly salary based on attendance
- Total expenses per video
- Days in production
- Equipment depreciation tracking
- Profit calculation
- Cost per view analysis

### Security
- JWT-based authentication
- Password hashing with bcryptjs
- Rate limiting
- CORS protection
- Helmet security headers
- Input validation with Joi

### Data Integrity
- Soft delete support (deleted_at column)
- Cascading deletes where appropriate
- Foreign key constraints
- Unique constraints
- Indexes for performance

### Audit Trail
- Audit logs for all entity changes
- Admin activity tracking
- Timestamp tracking (created_at, updated_at)

## Performance Optimizations

- Database indexes on frequently queried fields
- View for pre-calculated aggregations
- Pagination for large datasets
- Lazy loading in frontend
- Caching where applicable

## Deployment

### Production Checklist
- [ ] Update JWT_SECRET in .env
- [ ] Set NODE_ENV=production
- [ ] Configure FRONTEND_URL correctly
- [ ] Setup HTTPS/SSL
- [ ] Configure database backups
- [ ] Setup monitoring/logging
- [ ] Configure email service for password resets
- [ ] Setup CDN for static files
- [ ] Enable database connection pooling

### Recommended Hosting
- **Backend**: Heroku, AWS EC2, DigitalOcean, Railway
- **Frontend**: Vercel, Netlify, AWS S3 + CloudFront
- **Database**: AWS RDS, DigitalOcean Managed Databases

## Scaling Considerations

- Use connection pooling for database
- Implement caching layer (Redis)
- Use message queue for heavy operations
- Setup load balancing
- Separate read/write databases
- Archive old data