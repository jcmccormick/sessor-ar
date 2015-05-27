controllers = angular.module('controllers')
controllers.controller("ReportsController", [ '$scope', '$routeParams', '$location', '$resource'
	($scope, $routeParams, $location, $resource)->

		Report = $resource('/reports/:reportId', { reportId: "@id", format: 'json' })
		Report.query((results)-> $scope.reports = results)

		$scope.clearForm = -> $scope.keywords = undefined
		$scope.back      = -> $location.path("/reports")
		$scope.view      = (reportId)-> $location.path("/reports/#{reportId}")
		$scope.newReport = -> $location.path("/reports/new/")
		$scope.edit      = (reportId)-> $location.path("/reports/#{reportId}/edit/")
])