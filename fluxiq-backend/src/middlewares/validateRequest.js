'use strict';

const { ZodError } = require('zod');
const ApiResponse = require('../utils/response.helper');


function validateRequest(schema) {
  return (req, res, next) => {
    try {
      const parsed = schema.parse(req.body);
      req.body = parsed;
      next();
    } catch (error) {
      if (error instanceof ZodError) {
        const details = error.errors.map((e) => ({
          field: e.path.join('.'),
          message: e.message,
        }));

        return ApiResponse.error(res, {
          message: 'Validation failed',
          statusCode: 400,
          details,
        });
      }
      next(error);
    }
  };
}

module.exports = validateRequest;