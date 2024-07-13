const express = require('express');
const { Pool } = require('pg');

const app = express();

app.use(express.json());
const port = 3000;

const pool = new Pool({
  user: 'postgres',
  host: '192.168.1.20', // Địa chỉ IP của PostgreSQL server
  database: 'students',
  password: '123456',
  port: 5432,
});

// Route để lấy dữ liệu học sinh và trả về JSON
app.get('/students', async (req, res) => {
  try {
    const client = await pool.connect();
    const result = await client.query('SELECT * FROM students_info');
    const students = result.rows;
    client.release();
    res.json(students);
  } catch (err) {
    console.error('Error fetching data:', err);
    res.status(500).json({ error: 'Error fetching data' });
  }
});

app.patch('/update-student', async (req, res) => {
    const { id, name, age, grade } = req.body;
    try {
      const client = await pool.connect();
      const query = 'UPDATE students_info SET name=$1, age=$2, grade=$3 WHERE id=$4';
      const values = [name, age, grade, id];
      await client.query(query, values);
      client.release();
      res.status(200).send('Data updated successfully');
      console.log("Updated ok");
    } catch (err) {
      console.error('Error updating data:', err);
      res.status(500).send('Error updating data');
    }
  });

app.post('/new-student', async (req, res) => {
    const { name, age, grade } = req.body;
    try {
      const client = await pool.connect();
      const query = 'INSERT INTO students_info (name, age, grade) VALUES ($1, $2, $3)';
      const values = [name, age, grade];
      await client.query(query, values);
      client.release();
      res.status(200).send('Data updated successfully');
      console.log("new student ok");
    } catch (err) {
      console.error('Error updating data:', err);
      res.status(500).send('Error updating data');
    }
  });

app.delete('/delete-student', async (req, res) => {
  const { id } = req.body;
  try {
    const client = await pool.connect();
    const query = 'DELETE FROM students_info WHERE id=$1';
    const values = [id];
    await client.query(query, values);
    client.release();
    res.status(200).send('Data updated successfully');
    console.log("delete student ok");
  } catch (err) {    
    console.error('Error updating data:', err);
    res.status(500).send('Error updating data');
  }
});

app.delete('/delete-student', async (req, res) => {});
// Khởi động server
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
