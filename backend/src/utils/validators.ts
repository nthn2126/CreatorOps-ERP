import Joi from 'joi';

// Auth Validation
export const loginSchema = Joi.object({
  email: Joi.string().email().required(),
  password: Joi.string().min(6).required(),
});

export const changePasswordSchema = Joi.object({
  current_password: Joi.string().required(),
  new_password: Joi.string().min(6).required(),
  confirm_password: Joi.string().valid(Joi.ref('new_password')).required(),
});

export const forgotPasswordSchema = Joi.object({
  email: Joi.string().email().required(),
});

export const resetPasswordSchema = Joi.object({
  token: Joi.string().required(),
  new_password: Joi.string().min(6).required(),
  confirm_password: Joi.string().valid(Joi.ref('new_password')).required(),
});

// Category Validation
export const categorySchema = Joi.object({
  name: Joi.string().max(100).required(),
  type: Joi.string()
    .valid('expense', 'video', 'equipment', 'employee')
    .required(),
  description: Joi.string().allow(''),
});

// Employee Validation
export const employeeSchema = Joi.object({
  full_name: Joi.string().required(),
  phone_number: Joi.string().allow(''),
  category_id: Joi.string().uuid().required(),
  joining_date: Joi.date().required(),
  monthly_salary: Joi.number().positive().required(),
  status: Joi.string()
    .valid('active', 'inactive', 'on_leave')
    .default('active'),
  notes: Joi.string().allow(''),
});

// Attendance Validation
export const attendanceSchema = Joi.object({
  employee_id: Joi.string().uuid().required(),
  attendance_date: Joi.date().required(),
  status: Joi.string()
    .valid('present', 'absent', 'half_day', 'leave')
    .required(),
  notes: Joi.string().allow(''),
});

// Salary Slip Validation
export const salarySlipSchema = Joi.object({
  employee_id: Joi.string().uuid().required(),
  month_year: Joi.date().required(),
  bonus: Joi.number().default(0),
  advance: Joi.number().default(0),
  deductions: Joi.number().default(0),
});

// Video Validation
export const videoSchema = Joi.object({
  title: Joi.string().max(500).required(),
  category_id: Joi.string().uuid().required(),
  description: Joi.string().allow(''),
  idea_date: Joi.date().allow(null),
  planned_shoot_date: Joi.date().allow(null),
  actual_shoot_date: Joi.date().allow(null),
  upload_date: Joi.date().allow(null),
  assigned_cameraman_id: Joi.string().uuid().allow(null),
  assigned_editor_id: Joi.string().uuid().allow(null),
  status: Joi.string()
    .valid('idea', 'planning', 'shooting', 'editing', 'thumbnail', 'uploaded')
    .default('idea'),
  notes: Joi.string().allow(''),
});

// Expense Validation
export const expenseSchema = Joi.object({
  expense_date: Joi.date().required(),
  category_id: Joi.string().uuid().required(),
  video_id: Joi.string().uuid().allow(null),
  amount: Joi.number().positive().required(),
  description: Joi.string().allow(''),
  paid_by_employee_id: Joi.string().uuid().allow(null),
});

// Equipment Validation
export const equipmentSchema = Joi.object({
  name: Joi.string().required(),
  category_id: Joi.string().uuid().required(),
  purchase_date: Joi.date().required(),
  purchase_cost: Joi.number().positive().required(),
  current_value: Joi.number().positive().required(),
  status: Joi.string()
    .valid('available', 'in_use', 'damaged', 'repair')
    .default('available'),
  notes: Joi.string().allow(''),
});

// Sponsorship Validation
export const sponsorshipSchema = Joi.object({
  brand_name: Joi.string().required(),
  contact_person: Joi.string().allow(''),
  contact_number: Joi.string().allow(''),
  email: Joi.string().email().allow(''),
  deal_value: Joi.number().positive().required(),
  video_id: Joi.string().uuid().allow(null),
  status: Joi.string()
    .valid('lead', 'negotiation', 'approved', 'video_published', 'payment_received')
    .default('lead'),
});

// YouTube Revenue Validation
export const youtubeRevenueSchema = Joi.object({
  month_year: Joi.date().required(),
  amount: Joi.number().positive().required(),
  description: Joi.string().allow(''),
});

export const validate = (schema: Joi.ObjectSchema) => {
  return (req: any, res: any, next: any) => {
    const { error, value } = schema.validate(req.body, {
      abortEarly: false,
      stripUnknown: true,
    });

    if (error) {
      const messages = error.details.map((d) => `${d.path.join('.')}: ${d.message}`);
      return res.status(400).json({
        success: false,
        message: 'Validation error',
        errors: messages,
      });
    }

    req.body = value;
    next();
  };
};