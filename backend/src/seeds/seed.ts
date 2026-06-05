import bcryptjs from 'bcryptjs';
import { query } from '../config/database';

async function seedDatabase() {
  try {
    console.log('🌱 Seeding database...');

    // Create default admin user
    const adminEmail = 'admin@creatorops.com';
    const adminPassword = 'AdminPassword@123';
    const hashedPassword = await bcryptjs.hash(adminPassword, 10);

    await query(
      `INSERT INTO admin_users (email, password_hash, full_name, phone, is_active)
       VALUES ($1, $2, $3, $4, true)
       ON CONFLICT (email) DO NOTHING`,
      [adminEmail, hashedPassword, 'Admin User', '+1234567890']
    );

    console.log('✓ Admin user created');

    // Seed expense categories
    const expenseCategories = [
      { name: 'Fuel', type: 'expense', description: 'Fuel and transportation costs' },
      { name: 'Food', type: 'expense', description: 'Food and meals' },
      { name: 'Props', type: 'expense', description: 'Props and materials' },
      { name: 'Equipment', type: 'expense', description: 'Equipment purchases' },
      { name: 'Travel', type: 'expense', description: 'Travel expenses' },
      { name: 'Salary', type: 'expense', description: 'Employee salaries' },
      { name: 'Repairs', type: 'expense', description: 'Equipment repairs' },
      { name: 'Utilities', type: 'expense', description: 'Utilities and rent' },
      { name: 'Marketing', type: 'expense', description: 'Marketing and promotion' },
      { name: 'Miscellaneous', type: 'expense', description: 'Other expenses' },
    ];

    // Seed video categories
    const videoCategories = [
      { name: 'Challenge', type: 'video', description: 'Challenge videos' },
      { name: 'Camping', type: 'video', description: 'Camping videos' },
      { name: 'Experiment', type: 'video', description: 'Experiment videos' },
      { name: 'Survival', type: 'video', description: 'Survival videos' },
      { name: 'Prank', type: 'video', description: 'Prank videos' },
      { name: 'Vlog', type: 'video', description: 'Vlog videos' },
      { name: 'Behind The Scenes', type: 'video', description: 'Behind the scenes' },
      { name: 'Sponsored', type: 'video', description: 'Sponsored content' },
    ];

    // Seed equipment categories
    const equipmentCategories = [
      { name: 'Camera', type: 'equipment', description: 'Video cameras' },
      { name: 'Drone', type: 'equipment', description: 'Drones and aerial equipment' },
      { name: 'Microphone', type: 'equipment', description: 'Audio equipment' },
      { name: 'Light', type: 'equipment', description: 'Lighting equipment' },
      { name: 'Computer', type: 'equipment', description: 'Computers and processors' },
      { name: 'Storage', type: 'equipment', description: 'Storage devices' },
      { name: 'Vehicle', type: 'equipment', description: 'Vehicles' },
      { name: 'Accessories', type: 'equipment', description: 'Accessories and misc' },
    ];

    // Seed employee categories
    const employeeCategories = [
      { name: 'Editor', type: 'employee', description: 'Video editors' },
      { name: 'Cameraman', type: 'employee', description: 'Cameramen' },
      { name: 'Manager', type: 'employee', description: 'Managers' },
      { name: 'Driver', type: 'employee', description: 'Drivers' },
      { name: 'Cook', type: 'employee', description: 'Cooks' },
      { name: 'Content Creator', type: 'employee', description: 'Content creators' },
      { name: 'Helper', type: 'employee', description: 'Helpers' },
    ];

    const allCategories = [
      ...expenseCategories,
      ...videoCategories,
      ...equipmentCategories,
      ...employeeCategories,
    ];

    for (const category of allCategories) {
      await query(
        `INSERT INTO categories (name, type, description, is_active)
         VALUES ($1, $2, $3, true)
         ON CONFLICT (name) DO NOTHING`,
        [category.name, category.type, category.description]
      );
    }

    console.log('✓ Categories seeded');

    console.log('✨ Database seeding completed!');
    console.log('');
    console.log('🔐 Default Admin Credentials:');
    console.log(`📧 Email: ${adminEmail}`);
    console.log(`🔑 Password: ${adminPassword}`);
  } catch (error) {
    console.error('❌ Seeding error:', error);
    process.exit(1);
  }
}

seedDatabase().then(() => process.exit(0));