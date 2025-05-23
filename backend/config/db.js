const mongoose = require("mongoose");

const connectDB = async () => {
  try {
    // Opciones de conexión actualizadas
    const options = {
      useNewUrlParser: true,
      useUnifiedTopology: true,
      serverSelectionTimeoutMS: 5000,
      family: 4, // Forzar IPv4
    };

    const conn = await mongoose.connect(
      "mongodb://127.0.0.1:27017/gestion",
      options
    );

    console.log(
      `MongoDB conectado en: ${conn.connection.host}:${conn.connection.port}`
    );

    // Manejadores de eventos de conexión
    mongoose.connection.on("error", (err) => {
      console.error("Error de MongoDB:", err);
    });

    mongoose.connection.on("disconnected", () => {
      console.log("MongoDB desconectado");
    });

    return conn;
  } catch (error) {
    console.error(`Error conectando a MongoDB: ${error.message}`);
    process.exit(1);
  }
};

module.exports = connectDB;
