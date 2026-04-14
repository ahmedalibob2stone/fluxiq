

    class ApiResponse {

      static success(res, { message = 'Success', data = null, statusCode = 200 }) {
        return res.status(statusCode).json({
          success: true,
          message,
          data,
        });
      }


      static error(res, { message = 'Something went wrong', statusCode = 500, details = null }) {
        const response = {
          success: false,
          message,
        };

        if (details && process.env.NODE_ENV === 'development') {
          response.details = details;
        }

        return res.status(statusCode).json(response);
      }
    }

    module.exports = ApiResponse;