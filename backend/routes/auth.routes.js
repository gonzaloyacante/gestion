const express = require("express");
const router = express.Router();
const authController = require("../controllers/auth.controller");
const authMiddleware = require("../middlewares/auth.middleware");

// Rutas públicas
router.post("/register", authController.register);
router.post("/login", authController.login);
router.post("/forgot-password", authController.forgotPassword);
router.post("/reset-password", authController.resetPassword);

// Rutas protegidas
router.use(authMiddleware);
router.get("/verify", authController.verifyToken);
router.post("/logout", authController.logout);
router.get("/profile", authController.getProfile);

module.exports = router;
