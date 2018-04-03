const http = require('http');
const express = require('express');
const terminus = require('@godaddy/terminus');

const name = process.env.NAME || 'unknown';
const port = process.env.PORT || 3000;
const isHealthy = true;

const app = express();

app.get('/', (req, res) => {
  res.send(`Hello ${name}!`);
});

const server = http.createServer(app);

function onSignal() {
  console.log('Server is cleaning up');
}

async function onHealthCheck() {
  return isHealthy ? Promise.resolve() : Promise.reject();
}

terminus(server, {
  signal: 'SIGINT',
  healthChecks: {
    '/healthcheck': onHealthCheck,
  },
  onSignal
});

server.listen(port);

if (process.env.NODE_ENV != "production") {
  console.log(`Server is running at http://localhost:${port}`);
}
