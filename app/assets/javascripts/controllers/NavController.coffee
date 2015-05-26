controllers = angular.module('controllers')
controllers.controller("NavController", [ '$scope', '$routeParams', '$location', '$resource',
	($scope, $routeParams, $location, $resource)->
		$scope.reports	= ()-> $location.path("/reports/")
		$scope.home		= ()-> $location.path("/")
])