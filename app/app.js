const express = require('express')
const app = express()
const port = process.env.PORT;

app.listen(port);
console.log(`Server running at http://${process.env.IP}:${port}`);

app.get('/', (req, res) => {
  const name = process.env.NAME || 'unknown';
  res.send(`Hello ${name}!`);
});

// Ensure that NAME is set in the environment. If it is not, then the health
// check should fail.
app.get('/healthz', (req, res) => {
  if (process.env.NAME) {
    res.send(`ok`);
  } else {
    res.status(503);
    res.send('503 Service Unavailable');
  }
});
