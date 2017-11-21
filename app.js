const express = require('express')
const app = express()
const port = 3000;

app.listen(port);
console.log(`Server running at http://localhost: ${port}`);
app.get('/', (req, res) => {
  const name = process.env.NAME || 'unknown';
  res.send(`Hello ${name}!`);
});