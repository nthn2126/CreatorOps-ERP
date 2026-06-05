# API Documentation

## Authentication

All endpoints (except login) require JWT token in Authorization header:

```
Authorization: Bearer <token>
```

## Response Format

All responses follow this structure:

```json
{
  "success": true,
  "message": "Operation successful",
  "data": {}
}
```

## Endpoints

### Authentication

#### Login
- **URL**: `POST /api/auth/login`
- **Body**: 
  ```json
  {
    "email": "admin@creatorops.com",
    "password": "AdminPassword@123"
  }
  ```
- **Response**: Admin user object + JWT token

#### Get Current Admin
- **URL**: `GET /api/auth/me`
- **Auth**: Required

#### Change Password
- **URL**: `POST /api/auth/change-password`
- **Body**:
  ```json
  {
    "current_password": "old_password",
    "new_password": "new_password",
    "confirm_password": "new_password"
  }
  ```

#### Forgot Password
- **URL**: `POST /api/auth/forgot-password`
- **Body**:
  ```json
  {
    "email": "admin@creatorops.com"
  }
  ```

#### Reset Password
- **URL**: `POST /api/auth/reset-password`
- **Body**:
  ```json
  {
    "token": "reset_token",
    "new_password": "new_password",
    "confirm_password": "new_password"
  }
  ```

### Categories

#### Get Categories
- **URL**: `GET /api/categories`
- **Query**: `?type=expense&page=1&limit=10`
- **Auth**: Required

#### Get Category by ID
- **URL**: `GET /api/categories/:id`
- **Auth**: Required

#### Create Category
- **URL**: `POST /api/categories`
- **Body**:
  ```json
  {
    "name": "Travel",
    "type": "expense",
    "description": "Travel expenses"
  }
  ```

#### Update Category
- **URL**: `PUT /api/categories/:id`
- **Body**: Same as create

#### Toggle Category
- **URL**: `PATCH /api/categories/:id/toggle`
- **Body**:
  ```json
  {
    "is_active": true
  }
  ```

#### Delete Category
- **URL**: `DELETE /api/categories/:id`

### Employees

#### Get Employees
- **URL**: `GET /api/employees`
- **Query**: `?status=active&category_id=xxx&page=1&limit=10&search=name`

#### Get Employee by ID
- **URL**: `GET /api/employees/:id`

#### Create Employee
- **URL**: `POST /api/employees`
- **Body**:
  ```json
  {
    "full_name": "John Doe",
    "phone_number": "+1234567890",
    "category_id": "xxx",
    "joining_date": "2024-01-15",
    "monthly_salary": 30000,
    "status": "active",
    "notes": "Senior cameraman"
  }
  ```

#### Update Employee
- **URL**: `PUT /api/employees/:id`

#### Delete Employee
- **URL**: `DELETE /api/employees/:id`

#### Get Employee Attendance Summary
- **URL**: `GET /api/employees/:id/attendance-summary`
- **Query**: `?month=1&year=2024`

### Attendance

#### Get Attendance
- **URL**: `GET /api/attendance`
- **Query**: `?employee_id=xxx&from_date=2024-01-01&to_date=2024-01-31&page=1&limit=30`

#### Mark Attendance
- **URL**: `POST /api/attendance`
- **Body**:
  ```json
  {
    "employee_id": "xxx",
    "attendance_date": "2024-01-15",
    "status": "present",
    "notes": ""
  }
  ```

#### Update Attendance
- **URL**: `PUT /api/attendance/:id`

#### Bulk Mark Attendance
- **URL**: `POST /api/attendance/bulk-mark`
- **Body**:
  ```json
  {
    "attendance_records": [
      {
        "employee_id": "xxx",
        "attendance_date": "2024-01-15",
        "status": "present"
      }
    ]
  }
  ```

#### Get Monthly Summary
- **URL**: `GET /api/attendance/summary/:month/:year`

### Salary

#### Get Salary Slips
- **URL**: `GET /api/salary`
- **Query**: `?employee_id=xxx&month_year=2024-01-01&status=paid`

#### Generate Salary Slip
- **URL**: `POST /api/salary/generate`
- **Body**:
  ```json
  {
    "employee_id": "xxx",
    "month_year": "2024-01-01",
    "bonus": 5000,
    "advance": 2000,
    "deductions": 1000
  }
  ```

#### Mark Salary Paid
- **URL**: `PATCH /api/salary/:id/mark-paid`

#### Get Monthly Payroll Summary
- **URL**: `GET /api/salary/monthly-summary/:month/:year`

### Videos

#### Get Videos
- **URL**: `GET /api/videos`
- **Query**: `?status=idea&category_id=xxx&page=1&limit=10&search=title`

#### Get Video by ID
- **URL**: `GET /api/videos/:id`

#### Create Video
- **URL**: `POST /api/videos`
- **Body**:
  ```json
  {
    "title": "Amazing Camping Adventure",
    "category_id": "xxx",
    "description": "A fun camping adventure",
    "idea_date": "2024-01-01",
    "planned_shoot_date": "2024-01-15",
    "assigned_cameraman_id": "xxx",
    "assigned_editor_id": "xxx",
    "status": "idea"
  }
  ```

#### Update Video
- **URL**: `PUT /api/videos/:id`

#### Delete Video
- **URL**: `DELETE /api/videos/:id`

### Expenses

#### Get Expenses
- **URL**: `GET /api/expenses`
- **Query**: `?category_id=xxx&video_id=xxx&from_date=2024-01-01&to_date=2024-01-31&page=1&limit=20`

#### Create Expense
- **URL**: `POST /api/expenses`
- **Body**:
  ```json
  {
    "expense_date": "2024-01-15",
    "category_id": "xxx",
    "video_id": "xxx",
    "amount": 5000,
    "description": "Fuel for trip",
    "paid_by_employee_id": "xxx"
  }
  ```

#### Update Expense
- **URL**: `PUT /api/expenses/:id`

#### Delete Expense
- **URL**: `DELETE /api/expenses/:id`

#### Get Expense Statistics
- **URL**: `GET /api/expenses/stats/:period`
- **Query**: `?year=2024&month=1`

### Equipment

#### Get Equipment
- **URL**: `GET /api/equipment`
- **Query**: `?status=available&category_id=xxx&page=1&limit=10`

#### Create Equipment
- **URL**: `POST /api/equipment`
- **Body**:
  ```json
  {
    "name": "Sony A7IV",
    "category_id": "xxx",
    "purchase_date": "2023-06-01",
    "purchase_cost": 250000,
    "current_value": 200000,
    "status": "available"
  }
  ```

#### Update Equipment
- **URL**: `PUT /api/equipment/:id`

#### Delete Equipment
- **URL**: `DELETE /api/equipment/:id`

#### Get Equipment Statistics
- **URL**: `GET /api/equipment/stats/summary`

### Sponsorships

#### Get Sponsorships
- **URL**: `GET /api/sponsorships`
- **Query**: `?status=approved&payment_status=pending&page=1&limit=10`

#### Create Sponsorship
- **URL**: `POST /api/sponsorships`
- **Body**:
  ```json
  {
    "brand_name": "Nike",
    "contact_person": "John Smith",
    "contact_number": "+1234567890",
    "email": "john@nike.com",
    "deal_value": 500000,
    "video_id": "xxx",
    "status": "lead"
  }
  ```

#### Update Sponsorship
- **URL**: `PUT /api/sponsorships/:id`

#### Mark Payment Received
- **URL**: `PATCH /api/sponsorships/:id/mark-paid`
- **Body**:
  ```json
  {
    "amount_received": 500000
  }
  ```

#### Get Sponsorship Statistics
- **URL**: `GET /api/sponsorships/stats/summary`

### Dashboard

#### Get Dashboard Metrics
- **URL**: `GET /api/dashboard/metrics`
- **Returns**: All KPIs for dashboard

#### Get Expense Trend
- **URL**: `GET /api/dashboard/expense-trend`
- **Query**: `?months=12`

#### Get Expense Categories
- **URL**: `GET /api/dashboard/expense-categories`

#### Get Recent Expenses
- **URL**: `GET /api/dashboard/recent-expenses`
- **Query**: `?limit=5`

#### Get Upcoming Shoots
- **URL**: `GET /api/dashboard/upcoming-shoots`
- **Query**: `?limit=5`

### Reports

#### Attendance Report
- **URL**: `GET /api/reports/attendance`
- **Query**: `?month=1&year=2024&employee_id=xxx`

#### Salary Report
- **URL**: `GET /api/reports/salary`
- **Query**: `?month=1&year=2024&employee_id=xxx`

#### Expense Report
- **URL**: `GET /api/reports/expense`
- **Query**: `?from_date=2024-01-01&to_date=2024-01-31&category_id=xxx&video_id=xxx`

#### Employee Report
- **URL**: `GET /api/reports/employee`

#### Equipment Report
- **URL**: `GET /api/reports/equipment`

#### Sponsorship Report
- **URL**: `GET /api/reports/sponsorship`

#### Profit Report
- **URL**: `GET /api/reports/profit`
- **Query**: `?month=1&year=2024`

#### Video Cost Report
- **URL**: `GET /api/reports/video-cost`

## Error Codes

- `200` - Success
- `201` - Created
- `400` - Bad Request (Validation Error)
- `401` - Unauthorized (Invalid Token)
- `404` - Not Found
- `500` - Server Error

## Rate Limiting

- 100 requests per 15 minutes per IP

## CORS

Requests must include valid `Origin` header matching `FRONTEND_URL`
