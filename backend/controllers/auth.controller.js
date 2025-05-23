const User = require("../models/User");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");

// Función auxiliar para generar código
const generateResetCode = () =>
  Math.floor(100000 + Math.random() * 900000).toString();

// Registro
exports.register = async (req, res) => {
  try {
    const { name, email, password } = req.body;

    // Validar campos requeridos
    if (!name || !email || !password) {
      return res.status(400).json({
        message: "Todos los campos son requeridos",
      });
    }

    // Validar formato de email
    const emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
    if (!emailRegex.test(email)) {
      return res.status(400).json({
        message: "El formato del email no es válido",
      });
    }

    // Validar longitud de contraseña
    if (password.length < 6) {
      return res.status(400).json({
        message: "La contraseña debe tener al menos 6 caracteres",
      });
    }

    // Verificar si el usuario ya existe
    const userExists = await User.findOne({ email });
    if (userExists) {
      return res.status(400).json({
        message: "El email ya está registrado",
      });
    }

    // Crear nuevo usuario
    const user = new User({
      name,
      email,
      password,
    });

    await user.save();

    // Generar token
    const token = jwt.sign(
      { userId: user._id },
      process.env.JWT_SECRET || "tu_jwt_secret",
      {
        expiresIn: "7d",
      }
    );

    res.status(201).json({
      token,
      user: {
        id: user._id,
        name: user.name,
        email: user.email,
      },
    });
  } catch (error) {
    console.error("Error en registro:", error);
    res.status(500).json({ message: "Error en el servidor" });
  }
};

// Login
exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;

    // Validar campos
    if (!email || !password) {
      return res.status(400).json({
        message: "Por favor ingrese todos los campos",
      });
    }

    // Buscar usuario
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(401).json({
        message: "Credenciales inválidas",
      });
    }

    // Verificar contraseña
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).json({
        message: "Credenciales inválidas",
      });
    }

    // Generar token
    const token = jwt.sign(
      { userId: user._id },
      process.env.JWT_SECRET || "tu_jwt_secret",
      { expiresIn: "7d" }
    );

    res.json({
      token,
      user: {
        id: user._id,
        name: user.name,
        email: user.email,
      },
    });
  } catch (error) {
    console.error("Error en login:", error);
    res.status(500).json({
      message: "Error al iniciar sesión",
    });
  }
};

// Solicitar código de recuperación
exports.forgotPassword = async (req, res) => {
  try {
    const { email } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).json({ message: "Usuario no encontrado" });
    }

    const resetCode = generateResetCode();
    user.resetCode = resetCode;
    user.resetCodeExpires = Date.now() + 3600000; // 1 hora
    await user.save();

    // TODO: Implementar envío de email
    console.log("Código de recuperación:", resetCode);

    res.json({
      message: "Código de recuperación enviado",
      // Solo en desarrollo
      code: process.env.NODE_ENV === "development" ? resetCode : undefined,
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Verificar código
exports.verifyResetCode = async (req, res) => {
  try {
    const { email, code } = req.body;

    const user = await User.findOne({
      email,
      resetCode: code,
      resetCodeExpires: { $gt: Date.now() },
    });

    if (!user) {
      return res.status(400).json({ message: "Código inválido o expirado" });
    }

    res.json({ message: "Código válido" });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Resetear contraseña
exports.resetPassword = async (req, res) => {
  try {
    const { email, code, newPassword } = req.body;

    const user = await User.findOne({
      email,
      resetCode: code,
      resetCodeExpires: { $gt: Date.now() },
    });

    if (!user) {
      return res.status(400).json({ message: "Código inválido o expirado" });
    }

    user.password = newPassword;
    user.resetCode = undefined;
    user.resetCodeExpires = undefined;
    await user.save();

    res.json({ message: "Contraseña actualizada correctamente" });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Verify Token
exports.verifyToken = async (req, res) => {
  try {
    const user = await User.findById(req.userId).select("-password");
    if (!user) {
      return res.status(404).json({ message: "Usuario no encontrado" });
    }
    res.json({ user });
  } catch (error) {
    console.error("Error en verificación:", error);
    res.status(500).json({ message: "Error en el servidor" });
  }
};

// Logout
exports.logout = async (req, res) => {
  try {
    res.json({ message: "Sesión cerrada exitosamente" });
  } catch (error) {
    console.error("Error en logout:", error);
    res.status(500).json({ message: "Error en el servidor" });
  }
};

// Get Profile
exports.getProfile = async (req, res) => {
  try {
    const user = await User.findById(req.userId).select("-password");
    if (!user) {
      return res.status(404).json({ message: "Usuario no encontrado" });
    }
    res.json({ user });
  } catch (error) {
    console.error("Error en profile:", error);
    res.status(500).json({ message: "Error en el servidor" });
  }
};
