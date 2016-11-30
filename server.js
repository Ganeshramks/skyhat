var express = require('express');
var path = require('path');
var bodyParser = require('body-parser');
var expressSession = require('express-session');

var app = express();

var loginModule = require('./backend/loginModule.js');

app.use(expressSession({
	secret : '30ea63916d4ee5076e414683de53c7f2bca2c735',
	resave : false,
	saveUninitialized : false,
	cookie : {
		name : 'sid',
		maxAge : 3600000
	} 
}));

app.use('/libs', express.static(path.join(__dirname, '/node_modules/')));
app.use('/assets', express.static(path.join(__dirname, '/public')));

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
	extended:true
}));

app.get('/', function(req, res)
	{
		res.status(200);
		res.sendFile(path.join(__dirname,'/public/index.html'));
	});


server = app.listen(7000, function(){
	console.log("http server listening at port : %s", server.address().port);
});