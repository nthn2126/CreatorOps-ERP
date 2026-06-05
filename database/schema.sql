-- CreatorOps ERP Database Schema

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Admin Users Table
CREATE TABLE admin_users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    last_login TIMESTAMP,
    password_reset_token VARCHAR(255),
    password_reset_expires TIMESTAMP,
    two_factor_enabled BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP
);

-- Categories Table (Master Category System)
CREATE TABLE categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) UNIQUE NOT NULL,
    type VARCHAR(50) NOT NULL, -- 'expense', 'video', 'equipment', 'employee'
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP
);

CREATE INDEX idx_categories_type ON categories(type);
CREATE INDEX idx_categories_active ON categories(is_active);

-- Employees Table
CREATE TABLE employees (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    employee_id VARCHAR(50) UNIQUE NOT NULL, -- Auto-generated format: EMP-001
    full_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    category_id UUID NOT NULL REFERENCES categories(id),
    joining_date DATE NOT NULL,
    monthly_salary DECIMAL(12, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'active', -- 'active', 'inactive', 'on_leave'
    notes TEXT,
    profile_image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP
);

CREATE INDEX idx_employees_status ON employees(status);
CREATE INDEX idx_employees_category ON employees(category_id);

-- Attendance Table
CREATE TABLE attendance (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    employee_id UUID NOT NULL REFERENCES employees(id) ON DELETE CASCADE,
    attendance_date DATE NOT NULL,
    status VARCHAR(50) NOT NULL, -- 'present', 'absent', 'half_day', 'leave'
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,
    UNIQUE(employee_id, attendance_date)
);

CREATE INDEX idx_attendance_employee ON attendance(employee_id);
CREATE INDEX idx_attendance_date ON attendance(attendance_date);

-- Salary Slips Table
CREATE TABLE salary_slips (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    employee_id UUID NOT NULL REFERENCES employees(id) ON DELETE CASCADE,
    month_year DATE NOT NULL,
    monthly_salary DECIMAL(12, 2) NOT NULL,
    working_days INT NOT NULL,
    present_days INT NOT NULL,
    absent_days INT NOT NULL,
    half_days INT NOT NULL,
    leave_days INT NOT NULL,
    per_day_salary DECIMAL(12, 2) NOT NULL,
    salary_earned DECIMAL(12, 2) NOT NULL,
    bonus DECIMAL(12, 2) DEFAULT 0,
    advance DECIMAL(12, 2) DEFAULT 0,
    deductions DECIMAL(12, 2) DEFAULT 0,
    final_salary DECIMAL(12, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'pending', -- 'pending', 'paid', 'cancelled'
    paid_date TIMESTAMP,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP
);

CREATE INDEX idx_salary_slips_employee ON salary_slips(employee_id);
CREATE INDEX idx_salary_slips_month ON salary_slips(month_year);

-- Videos Table
CREATE TABLE videos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    video_id VARCHAR(50) UNIQUE NOT NULL, -- Auto-generated format: VID-001
    title VARCHAR(500) NOT NULL,
    category_id UUID NOT NULL REFERENCES categories(id),
    description TEXT,
    idea_date DATE,
    planned_shoot_date DATE,
    actual_shoot_date DATE,
    upload_date DATE,
    assigned_cameraman_id UUID REFERENCES employees(id),
    assigned_editor_id UUID REFERENCES employees(id),
    status VARCHAR(50) DEFAULT 'idea', -- 'idea', 'planning', 'shooting', 'editing', 'thumbnail', 'uploaded'
    views INT DEFAULT 0,
    thumbnail_url VARCHAR(255),
    video_url VARCHAR(255),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP
);

CREATE INDEX idx_videos_status ON videos(status);
CREATE INDEX idx_videos_category ON videos(category_id);
CREATE INDEX idx_videos_upload_date ON videos(upload_date);

-- Expenses Table
CREATE TABLE expenses (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    expense_date DATE NOT NULL,
    category_id UUID NOT NULL REFERENCES categories(id),
    video_id UUID REFERENCES videos(id) ON DELETE SET NULL,
    amount DECIMAL(12, 2) NOT NULL,
    description TEXT,
    paid_by_employee_id UUID REFERENCES employees(id),
    receipt_url VARCHAR(255),
    receipt_type VARCHAR(50), -- 'image', 'pdf', etc.
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP
);

CREATE INDEX idx_expenses_date ON expenses(expense_date);
CREATE INDEX idx_expenses_category ON expenses(category_id);
CREATE INDEX idx_expenses_video ON expenses(video_id);

-- Equipment Table
CREATE TABLE equipment (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    category_id UUID NOT NULL REFERENCES categories(id),
    purchase_date DATE NOT NULL,
    purchase_cost DECIMAL(12, 2) NOT NULL,
    current_value DECIMAL(12, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'available', -- 'available', 'in_use', 'damaged', 'repair'
    notes TEXT,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP
);

CREATE INDEX idx_equipment_status ON equipment(status);
CREATE INDEX idx_equipment_category ON equipment(category_id);

-- Equipment Maintenance Records
CREATE TABLE equipment_maintenance (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    equipment_id UUID NOT NULL REFERENCES equipment(id) ON DELETE CASCADE,
    maintenance_date DATE NOT NULL,
    description TEXT NOT NULL,
    cost DECIMAL(12, 2),
    type VARCHAR(50) NOT NULL, -- 'maintenance', 'repair', 'damage'
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP
);

CREATE INDEX idx_equipment_maintenance_equipment ON equipment_maintenance(equipment_id);

-- Sponsorships Table
CREATE TABLE sponsorships (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    brand_name VARCHAR(255) NOT NULL,
    contact_person VARCHAR(255),
    contact_number VARCHAR(20),
    email VARCHAR(255),
    deal_value DECIMAL(12, 2) NOT NULL,
    video_id UUID REFERENCES videos(id) ON DELETE SET NULL,
    status VARCHAR(50) DEFAULT 'lead', -- 'lead', 'negotiation', 'approved', 'video_published', 'payment_received'
    payment_status VARCHAR(50) DEFAULT 'pending', -- 'pending', 'received', 'partial'
    amount_received DECIMAL(12, 2) DEFAULT 0,
    payment_date TIMESTAMP,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP
);

CREATE INDEX idx_sponsorships_status ON sponsorships(status);
CREATE INDEX idx_sponsorships_video ON sponsorships(video_id);

-- YouTube Revenue Table (Manual Entry)
CREATE TABLE youtube_revenue (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    month_year DATE NOT NULL,
    amount DECIMAL(12, 2) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,
    UNIQUE(month_year)
);

-- Audit Logs Table
CREATE TABLE audit_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    admin_id UUID NOT NULL REFERENCES admin_users(id),
    entity_type VARCHAR(100) NOT NULL, -- 'employee', 'video', 'expense', etc.
    entity_id UUID NOT NULL,
    action VARCHAR(50) NOT NULL, -- 'create', 'update', 'delete'
    old_values JSONB,
    new_values JSONB,
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_audit_logs_entity ON audit_logs(entity_type, entity_id);
CREATE INDEX idx_audit_logs_admin ON audit_logs(admin_id);
CREATE INDEX idx_audit_logs_created ON audit_logs(created_at);

-- Video Assignment History
CREATE TABLE video_assignment_history (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    video_id UUID NOT NULL REFERENCES videos(id) ON DELETE CASCADE,
    employee_id UUID NOT NULL REFERENCES employees(id),
    role VARCHAR(50) NOT NULL, -- 'cameraman', 'editor'
    assigned_date TIMESTAMP NOT NULL,
    removed_date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_video_assignment_video ON video_assignment_history(video_id);
CREATE INDEX idx_video_assignment_employee ON video_assignment_history(employee_id);

-- Views for Dashboard Calculations
CREATE VIEW monthly_expenses AS
SELECT 
    DATE_TRUNC('month', expense_date)::DATE as month,
    SUM(amount) as total
FROM expenses
WHERE deleted_at IS NULL
GROUP BY DATE_TRUNC('month', expense_date);

CREATE VIEW monthly_salaries AS
SELECT 
    month_year,
    SUM(final_salary) as total
FROM salary_slips
WHERE deleted_at IS NULL AND status = 'paid'
GROUP BY month_year;

CREATE VIEW video_expenses AS
SELECT 
    video_id,
    SUM(amount) as total_cost,
    COUNT(*) as expense_count
FROM expenses
WHERE deleted_at IS NULL
GROUP BY video_id;

CREATE VIEW sponsorship_revenue AS
SELECT 
    DATE_TRUNC('month', payment_date)::DATE as month,
    SUM(amount_received) as total
FROM sponsorships
WHERE deleted_at IS NULL AND payment_status IN ('received', 'partial')
GROUP BY DATE_TRUNC('month', payment_date);

-- Timestamps Update Trigger Function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply triggers to all tables
CREATE TRIGGER update_admin_users_updated_at BEFORE UPDATE ON admin_users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_employees_updated_at BEFORE UPDATE ON employees
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_attendance_updated_at BEFORE UPDATE ON attendance
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_videos_updated_at BEFORE UPDATE ON videos
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_expenses_updated_at BEFORE UPDATE ON expenses
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_equipment_updated_at BEFORE UPDATE ON equipment
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_sponsorships_updated_at BEFORE UPDATE ON sponsorships
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
