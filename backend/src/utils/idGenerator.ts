import { query } from '../config/database';

export const generateEmployeeId = async (): Promise<string> => {
  const result = await query(
    'SELECT COUNT(*) as count FROM employees WHERE deleted_at IS NULL'
  );
  const count = parseInt(result.rows[0].count) + 1;
  return `EMP-${String(count).padStart(5, '0')}`;
};

export const generateVideoId = async (): Promise<string> => {
  const result = await query(
    'SELECT COUNT(*) as count FROM videos WHERE deleted_at IS NULL'
  );
  const count = parseInt(result.rows[0].count) + 1;
  return `VID-${String(count).padStart(5, '0')}`;
};

export const generateExpenseId = async (): Promise<string> => {
  const result = await query(
    'SELECT COUNT(*) as count FROM expenses WHERE deleted_at IS NULL'
  );
  const count = parseInt(result.rows[0].count) + 1;
  return `EXP-${String(count).padStart(5, '0')}`;
};