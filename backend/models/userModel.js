const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  email: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  // Más campos en el futuro: nombre, rol, etc.
});

module.exports = mongoose.model("User", userSchema);
