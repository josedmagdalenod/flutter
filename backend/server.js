const express = require('express');
const { Pool } = require('pg');
const app = express();
const PORT = process.env.PORT || 4000;

// Middleware para JSON (con límite de 10mb para soportar imágenes en base64)
app.use(express.json({limit: '10mb'}));

// Configuración de la conexión a PostgreSQL
const pool = new Pool({
  user: 'nuevo_sistema',
  host: '10.20.22.6',
  database: 'postgres',
  password: 'admin',
  port: 5433,
});

// Ruta optimizada para consultar solo las columnas requeridas de "mensajes_globales"
app.get('/api/mensajes', async (req, res) => {
  try {
    // Seleccionamos exclusivamente las columnas que pidió la app
    // Usamos 'AS' para renombrar si los nombres en tu BD difieren un poco
    const query = `
      SELECT 
        fecha, 
        contenido, 
        imagen, 
        moneda, 
        name_group 
      FROM mensajes_globales 
      ORDER BY fecha DESC 
      LIMIT 50;
    `;
    
    const result = await pool.query(query);

    res.status(200).json({
      success: true,
      data: result.rows, // Retornará un array con objetos que solo contienen estas 5 columnas
    });
  } catch (error) {
    console.error('Error al obtener los mensajes para la app:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});

app.listen(PORT, () => {
  console.log(`Servidor de lectura corriendo en http://localhost:${PORT}`);
});