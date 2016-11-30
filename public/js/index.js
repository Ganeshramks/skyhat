app = angular.module('skyhat', ['ngMaterial', 'ngRoute']);

app.controller('indexCtrl', ["$scope", "$http", "$window", function($scope, $http, $window)
{
	$scope.user = {};
	$scope.msgStyle = {'color':'blue', 'text-align':'center'};
	
	$scope.login = function()
	{
		$http.post('/login', $scope.user).then(function(success)
		{
			$scope.response = success.data;
			if ($scope.response.statusCode == 302) 
			{
				$scope.msgStyle.color = "green";
				$window.location = '/dashboard';
			}
			else if ($scope.response.statusCode >=400)
			{
				$scope.msgStyle.color = "red";
			}
		}, function(err){
			$scope.response = err.data;
		});
	};
}]);