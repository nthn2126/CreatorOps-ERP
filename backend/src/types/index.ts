// Admin User
export interface AdminUser {
  id: string;
  email: string;
  full_name: string;
  phone?: string;
  last_login?: Date;
  is_active: boolean;
  created_at: Date;
  updated_at: Date;
}

// JWT Payload
export interface JWTPayload {
  id: string;
  email: string;
  iat?: number;
  exp?: number;
}

// Category
export interface Category {
  id: string;
  name: string;
  type: 'expense' | 'video' | 'equipment' | 'employee';
  description?: string;
  is_active: boolean;
  created_at: Date;
  updated_at: Date;
}

// Employee
export interface Employee {
  id: string;
  employee_id: string;
  full_name: string;
  phone_number?: string;
  category_id: string;
  joining_date: Date;
  monthly_salary: number;
  status: 'active' | 'inactive' | 'on_leave';
  notes?: string;
  profile_image_url?: string;
  created_at: Date;
  updated_at: Date;
}

// Attendance
export interface Attendance {
  id: string;
  employee_id: string;
  attendance_date: Date;
  status: 'present' | 'absent' | 'half_day' | 'leave';
  notes?: string;
  created_at: Date;
  updated_at: Date;
}

// Salary Slip
export interface SalarySlip {
  id: string;
  employee_id: string;
  month_year: Date;
  monthly_salary: number;
  working_days: number;
  present_days: number;
  absent_days: number;
  half_days: number;
  leave_days: number;
  per_day_salary: number;
  salary_earned: number;
  bonus: number;
  advance: number;
  deductions: number;
  final_salary: number;
  status: 'pending' | 'paid' | 'cancelled';
  paid_date?: Date;
  notes?: string;
  created_at: Date;
  updated_at: Date;
}

// Video
export interface Video {
  id: string;
  video_id: string;
  title: string;
  category_id: string;
  description?: string;
  idea_date?: Date;
  planned_shoot_date?: Date;
  actual_shoot_date?: Date;
  upload_date?: Date;
  assigned_cameraman_id?: string;
  assigned_editor_id?: string;
  status: 'idea' | 'planning' | 'shooting' | 'editing' | 'thumbnail' | 'uploaded';
  views: number;
  thumbnail_url?: string;
  video_url?: string;
  notes?: string;
  created_at: Date;
  updated_at: Date;
}

// Expense
export interface Expense {
  id: string;
  expense_date: Date;
  category_id: string;
  video_id?: string;
  amount: number;
  description?: string;
  paid_by_employee_id?: string;
  receipt_url?: string;
  receipt_type?: string;
  created_at: Date;
  updated_at: Date;
}

// Equipment
export interface Equipment {
  id: string;
  name: string;
  category_id: string;
  purchase_date: Date;
  purchase_cost: number;
  current_value: number;
  status: 'available' | 'in_use' | 'damaged' | 'repair';
  notes?: string;
  image_url?: string;
  created_at: Date;
  updated_at: Date;
}

// Equipment Maintenance
export interface EquipmentMaintenance {
  id: string;
  equipment_id: string;
  maintenance_date: Date;
  description: string;
  cost?: number;
  type: 'maintenance' | 'repair' | 'damage';
  notes?: string;
  created_at: Date;
  updated_at: Date;
}

// Sponsorship
export interface Sponsorship {
  id: string;
  brand_name: string;
  contact_person?: string;
  contact_number?: string;
  email?: string;
  deal_value: number;
  video_id?: string;
  status: 'lead' | 'negotiation' | 'approved' | 'video_published' | 'payment_received';
  payment_status: 'pending' | 'received' | 'partial';
  amount_received: number;
  payment_date?: Date;
  notes?: string;
  created_at: Date;
  updated_at: Date;
}

// YouTube Revenue
export interface YouTubeRevenue {
  id: string;
  month_year: Date;
  amount: number;
  description?: string;
  created_at: Date;
  updated_at: Date;
}

// Audit Log
export interface AuditLog {
  id: string;
  admin_id: string;
  entity_type: string;
  entity_id: string;
  action: 'create' | 'update' | 'delete';
  old_values?: Record<string, any>;
  new_values?: Record<string, any>;
  ip_address?: string;
  user_agent?: string;
  created_at: Date;
}

// Dashboard Metrics
export interface DashboardMetrics {
  total_employees: number;
  active_employees: number;
  total_videos: number;
  videos_in_progress: number;
  videos_uploaded_this_month: number;
  monthly_expenses: number;
  monthly_salaries: number;
  monthly_profit: number;
  equipment_count: number;
  active_sponsorships: number;
  expense_trend: Array<{ month: string; amount: number }>;
  revenue_trend: Array<{ month: string; amount: number }>;
  recent_expenses: Expense[];
  upcoming_shoots: Video[];
}

// API Response
export interface ApiResponse<T> {
  success: boolean;
  message: string;
  data?: T;
  error?: string;
  pagination?: {
    page: number;
    limit: number;
    total: number;
    pages: number;
  };
}