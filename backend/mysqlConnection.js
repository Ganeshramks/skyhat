var mysql = require('../node_modules/mysql');

module.exports = {};

module.exports.createMySqlConnection = function()
{
	var connection = mysql.createConnection({
		host : 'localhost',
		user : 'root',
		password : 'Elephant10',
		database : 'skyhat'
	});

	return connection;
};