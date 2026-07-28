const express = require('express');
const { Pool } = require('pg');
const app = express();
const PORT = process.env.PORT || 4000;

// Middleware para JSON
app.use(express.json());

// Configuración de la conexión a PostgreSQL
// (Asegúrate de ajustar estos datos según tus credenciales locales o de tu servidor)
const pool = new Pool({
  user: 'nuevo_sistema',
  host: '10.20.22.6',
  database: 'postgres',
  password: 'admin',
  port: 5433,
});

// Ruta de prueba básica
app.get('/', (req, res) => {
  res.json({ message: '¡Servidor funcionando correctamente!' });
});

// Ruta para recibir e insertar mensajes en la base de datos
app.post('/integrations/messages', async (req, res) => {
  try {
    const { chat_group_name, message_body, media_url, date_time } = req.body;

    const query = `
      INSERT INTO messages (chat_group_name, message_body, media_url, date_time)
      VALUES ($1, $2, $3, $4)
      RETURNING *;
    `;
    
    const values = [chat_group_name, message_body, media_url, date_time];
    const result = await pool.query(query, values);

    res.status(201).json({
      success: true,
      message: 'Mensaje guardado correctamente',
      data: result.rows[0],
    });
  } catch (error) {
    console.error('Error al guardar el mensaje:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});

// Iniciar el servidor
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});