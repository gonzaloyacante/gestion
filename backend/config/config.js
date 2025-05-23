require("dotenv").config();

module.exports = {
  PORT: process.env.PORT || 5000,
  MONGODB_URI: process.env.MONGODB_URI || "mongodb://localhost:27017/gestion",
  JWT_SECRET: process.env.JWT_SECRET || "your_jwt_secret_key_here",
  CORS_ORIGIN: process.env.CORS_ORIGIN || "*",
  NODE_ENV: process.env.NODE_ENV || "development",
};
