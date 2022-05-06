const express = require('express')

const app = express()

app.get('/health/ping', function (req, res) {
  res.end()
})

app.get('/', function (req, res) {
  let date = new Date()
  res.json(date.toString())
})

app.listen(8080)
console.log('Server started listening')
