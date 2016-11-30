var mysqlConnection = require('./mysqlConnection.js');

module.exports = {};

module.exports.login = function(req, res)
{
	var user = req.body;
	connection = mysqlConnection.createMySqlConnection();

	var query = "SELECT * FROM users WHERE username = ?";
	connection.query(query, user.username, function(err, rows)
	{
		connection.end();
		
		var response = {};
		response.statusCode = 200;
		response.redirectUrl = null;
		var statusCode = 200;

		if (err) 
		{
			statusCode = 500;
			response.statusCode = 500;
			response.message = "Please try again in sometime";
		}

		if (rows.length == 1) 
		{
			if (rows[0].password == user.password) 
			{
				//set session 
				req.session.userDetails = rows[0];

				//response
				response.statusCode = 302;
				response.message = "Welcome! Please wait...";
				response.redirectUrl = "/dashboard";
			}
			else
			{
				response.statusCode = 401;
				response.message = "Incorrect Credentials";
			}
		}
		else if(rows.length == 0)
		{
			response.statusCode = 400;
			response.message = "User Not Registered";
		}

		res.status(statusCode);
		res.json(response);
	});
};

module.exports.checkSession = function(req, res, next)
{
	if (req.session.userDetails) 
	{
		next();
	}
	else
	{
		res.status(302);
		res.redirect('/');
	}
};