const mongoose = require("mongoose");
const bcrypt = require("bcryptjs");

const userSchema = new mongoose.Schema({
  name: {
    type: String,
    required: [true, "El nombre es requerido"],
  },
  email: {
    type: String,
    required: [true, "El email es requerido"],
    unique: true,
    lowercase: true,
  },
  password: {
    type: String,
    required: [true, "La contraseña es requerida"],
    minlength: 6,
  },
  resetCode: String,
  resetCodeExpires: Date,
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

// Hash password antes de guardar
userSchema.pre("save", async function (next) {
  if (!this.isModified("password")) return next();

  const salt = await bcrypt.genSalt(10);
  this.password = await bcrypt.hash(this.password, salt);
  next();
});

module.exports = mongoose.model("User", userSchema);
