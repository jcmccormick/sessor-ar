controllers = angular.module('controllers')
controllers.controller("ReportsController", [ '$scope', '$routeParams', '$resource', '$location', '$sessionStorage', 'ReportsFactory', 'ReportFactory',
	($scope, $routeParams, $resource, $location, $sessionStorage, ReportsFactory, ReportFactory)->
		$scope.$storage = $sessionStorage
		
		ReportsFactory.query().$promise.then((response)->$scope.$storage = response)

		$scope.reports   = $scope.$storage.reports

		console.log $scope.$storage.reports

		$scope.clearForm = -> $scope.keywords = []
		$scope.back      = -> $location.path("/reports")
		$scope.newReport = -> $location.path("/reports/new")
		$scope.edit      = (id)-> $location.path("/reports/#{id}/edit")
		$scope.view      = (id)-> $location.path("/reports/#{id}")
])