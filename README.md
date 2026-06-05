# CreatorOps ERP

A production-ready Enterprise Resource Planning (ERP) system for managing YouTube production companies.

## Features

- **Single Admin Login** - Secure authentication system
- **Dashboard** - Real-time metrics and KPIs
- **Employee Management** - Track employees, roles, and salaries
- **Attendance Management** - Daily attendance with auto-calculations
- **Salary Management** - Automated salary calculations with PDF slips
- **Video Management** - Complete video production lifecycle
- **Expense Management** - Track expenses by category, video, or employee
- **Equipment Management** - Inventory and maintenance tracking
- **Sponsorship Management** - Brand deals and revenue tracking
- **Profit & Analytics** - Real-time financial analytics
- **Reports & Export** - Generate PDF and Excel reports
- **Dark/Light Mode** - Responsive design with theme support
- **Mobile Friendly** - Works on all devices

## Tech Stack

- **Frontend**: React 18, TypeScript, Tailwind CSS
- **Backend**: Node.js, Express.js
- **Database**: PostgreSQL
- **Authentication**: JWT
- **File Storage**: AWS S3 / Local Storage
- **Reporting**: PDFKit, ExcelJS

## Project Structure

```
CreatorOps-ERP/
├── backend/
│   ├── src/
│   │   ├── config/
│   │   ├── controllers/
│   │   ├── middleware/
│   │   ├── models/
│   │   ├── routes/
│   │   ├── services/
│   │   ├── utils/
│   │   └── app.ts
│   ├── migrations/
│   ├── seeds/
│   ├── .env.example
│   └── package.json
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   ├── services/
│   │   ├── context/
│   │   ├── types/
│   │   └── App.tsx
│   ├── .env.example
│   └── package.json
├── database/
│   ├── schema.sql
│   └── seeds.sql
└── docs/
    ├── API.md
    ├── INSTALLATION.md
    └── ARCHITECTURE.md
```

## Quick Start

### Prerequisites
- Node.js 18+
- PostgreSQL 13+
- npm or yarn

### Installation

1. Clone the repository
```bash
git clone https://github.com/nthn2126/CreatorOps-ERP.git
cd CreatorOps-ERP
```

2. Setup Backend
```bash
cd backend
npm install
cp .env.example .env
# Configure your database in .env
npm run migrate
npm run seed
npm start
```

3. Setup Frontend
```bash
cd ../frontend
npm install
cp .env.example .env
npm start
```

4. Access the application
- Open http://localhost:3000
- Admin Login credentials will be provided after seeding

## Documentation

- [Installation Guide](docs/INSTALLATION.md)
- [API Documentation](docs/API.md)
- [Architecture](docs/ARCHITECTURE.md)

## License

Proprietary - CreatorOps ERP

## Support

For issues and feature requests, please create an issue in the GitHub repository.
