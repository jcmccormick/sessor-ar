controllers = angular.module('controllers')
controllers.controller("NavController", [ '$scope', '$routeParams', '$location'
	($scope, $routeParams, $location)->
		$scope.draggable = -> $location.path("/draggable/")
		$scope.reports	 = -> $location.path("/reports/")
		$scope.home		 = -> $location.path("/")
		$scope.back      = -> $location.path("/reports")
		$scope.newReport = -> $location.path("/reports/new")
		$scope.clearForm = -> $scope.keywords = []
])