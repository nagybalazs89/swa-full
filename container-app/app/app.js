var express = require('express');
var app = express();

app.get('/api', function (req, res) {
  res.send('Hello World!');
});

app.get('/api/config', function (req, res) {
    res.json({
        environment: process.env.ENV,
        hello: `I'm a development stage feature!`
    })
});

app.listen(80, function () {
  console.log('Example app listening on port 80!');
});