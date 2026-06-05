#!/bin/bash

# CreatorOps ERP Installation Guide

echo "🚀 CreatorOps ERP Installation"
echo "================================"

# Check Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 18+"
    exit 1
fi

echo "✓ Node.js version: $(node -v)"

# Check PostgreSQL
if ! command -v psql &> /dev/null; then
    echo "❌ PostgreSQL is not installed. Please install PostgreSQL 13+"
    exit 1
fi

echo "✓ PostgreSQL is installed"

# Setup Backend
echo ""
echo "Setting up Backend..."
cd backend
cp .env.example .env
npm install
echo "✓ Backend dependencies installed"

# Create database
echo ""
echo "Creating database..."
psql -U postgres -c "CREATE DATABASE creatorops_erp;"
psql -U postgres -d creatorops_erp -f ../database/schema.sql
echo "✓ Database created and schema applied"

# Setup Frontend
echo ""
echo "Setting up Frontend..."
cd ../frontend
cp .env.example .env
npm install
echo "✓ Frontend dependencies installed"

echo ""
echo "================================"
echo "✓ Installation complete!"
echo ""
echo "📝 Next steps:"
echo "1. Update backend/.env with your database credentials"
echo "2. Update frontend/.env if needed"
echo "3. Run: npm run dev (from backend directory)"
echo "4. Run: npm start (from frontend directory)"
echo ""
echo "🔐 Default Admin Credentials:"
echo "Email: admin@creatorops.com"
echo "Password: AdminPassword@123"
echo ""
echo "🌐 Access the application at: http://localhost:3000"