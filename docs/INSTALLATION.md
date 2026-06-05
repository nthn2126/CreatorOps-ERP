# CreatorOps ERP Installation Guide

## Prerequisites

- Node.js 18+
- PostgreSQL 13+
- npm or yarn

## Installation Steps

### 1. Clone Repository
```bash
git clone https://github.com/nthn2126/CreatorOps-ERP.git
cd CreatorOps-ERP
```

### 2. Automatic Installation (Linux/Mac)
```bash
bash install.sh
```

### 3. Manual Installation

#### Backend Setup
```bash
cd backend
cp .env.example .env

# Edit .env with your PostgreSQL credentials
nano .env

npm install
npm run migrate
npm run seed
npm run dev
```

#### Database Setup
```bash
# Create database
creatdb creatorops_erp

# Apply schema
psql -U postgres -d creatorops_erp -f ../database/schema.sql
```

#### Frontend Setup
```bash
cd frontend
cp .env.example .env
npm install
npm start
```

## Environment Configuration

### Backend (.env)
```
PORT=5000
NODE_ENV=development
DB_HOST=localhost
DB_PORT=5432
DB_NAME=creatorops_erp
DB_USER=postgres
DB_PASSWORD=your_password
JWT_SECRET=your_secret_key
FRONTEND_URL=http://localhost:3000
```

### Frontend (.env)
```
REACT_APP_API_URL=http://localhost:5000/api
```

## Default Admin Login

- Email: `admin@creatorops.com`
- Password: `AdminPassword@123`

**⚠️ Change password immediately after first login!**

## Running the Application

### Development Mode

Terminal 1 (Backend):
```bash
cd backend
npm run dev
```

Terminal 2 (Frontend):
```bash
cd frontend
npm start
```

### Production Mode

Backend:
```bash
cd backend
npm run build
npm start
```

Frontend:
```bash
cd frontend
npm run build
npm start
```

## Troubleshooting

### Port Already in Use
```bash
# Change PORT in .env file
# Or kill existing process
lsof -i :5000
kill -9 <PID>
```

### Database Connection Error
- Check PostgreSQL is running
- Verify database credentials in .env
- Ensure database exists

### CORS Errors
- Verify FRONTEND_URL in backend .env
- Check API_URL in frontend .env

## Support

For issues and feature requests, please create an issue on GitHub.