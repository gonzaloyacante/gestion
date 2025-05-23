const jwt = require("jsonwebtoken");
const { JWT_SECRET } = require("../config/config");

const authMiddleware = async (req, res, next) => {
  try {
    const token = req.header("Authorization")?.replace("Bearer ", "");

    if (!token) {
      return res.status(401).json({
        message: "No autorizado - Token no proporcionado",
      });
    }

    const decoded = jwt.verify(token, JWT_SECRET);
    req.userId = decoded.userId;
    next();
  } catch (error) {
    console.error("Error de autenticación:", error);
    res.status(401).json({
      message: "Token inválido o expirado",
      error: process.env.NODE_ENV === "development" ? error.message : undefined,
    });
  }
};

module.exports = authMiddleware;
