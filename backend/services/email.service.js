const sgMail = require("../config/email.config");

class EmailService {
  async sendResetCode(email, code) {
    try {
      const msg = {
        to: email,
        from: process.env.SENDGRID_FROM_EMAIL,
        subject: "Código de Recuperación - GestiON",
        html: `
          <div style="font-family: Arial, sans-serif; padding: 20px;">
            <h2>Recuperación de Contraseña</h2>
            <p>Has solicitado recuperar tu contraseña.</p>
            <p>Tu código de verificación es:</p>
            <h1 style="color: #4CAF50; text-align: center;">${code}</h1>
            <p>Este código expirará en 1 hora.</p>
            <hr>
            <p style="color: #666; font-size: 12px;">
              Si no solicitaste este código, puedes ignorar este correo.
            </p>
          </div>
        `,
      };

      await sgMail.send(msg);
    } catch (error) {
      console.error("Error enviando email:", error);
      throw new Error("Error al enviar el código de verificación");
    }
  }
}

module.exports = new EmailService();
