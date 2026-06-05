import { Request, Response, NextFunction } from 'express';

export class AppError extends Error {
  constructor(
    public statusCode: number,
    message: string
  ) {
    super(message);
    Error.captureStackTrace(this, this.constructor);
  }
}

export const errorHandler = (
  error: Error | AppError,
  req: Request,
  res: Response,
  next: NextFunction
) => {
  console.error('Error:', error);

  if (error instanceof AppError) {
    return res.status(error.statusCode).json({
      success: false,
      message: error.message,
    });
  }

  // Validation error
  if (error.message.includes('ValidationError')) {
    return res.status(400).json({
      success: false,
      message: error.message,
    });
  }

  // Database error
  if (error.message.includes('database') || error.message.includes('query')) {
    return res.status(500).json({
      success: false,
      message: 'Database error occurred',
    });
  }

  return res.status(500).json({
    success: false,
    message: 'Internal server error',
  });
};