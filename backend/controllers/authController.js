const User = require("../models/userModel");
const jwt = require("jsonwebtoken");

exports.register = async (req, res) => {
  try {
    const { email, password } = req.body;

    // Aquí deberías agregar validación, hash de password, etc.
    const user = new User({ email, password });
    await user.save();

    res.status(201).json({ message: "Usuario creado" });
  } catch (error) {
    res.status(500).json({ error: "Error creando usuario" });
  }
};

exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;

    // Aquí agregar lógica de verificación de usuario y password
    const user = await User.findOne({ email });
    if (!user || user.password !== password) {
      return res.status(401).json({ error: "Credenciales inválidas" });
    }

    // Generar JWT
    const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, {
      expiresIn: "1d",
    });
    res.json({ token });
  } catch (error) {
    res.status(500).json({ error: "Error en login" });
  }
};
exports.getUser = async (req, res) => {
  try {
    const user = await User.findById(req.user.id);
    if (!user) {
      return res.status(404).json({ error: "Usuario no encontrado" });
    }
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: "Error obteniendo usuario" });
  }
};
