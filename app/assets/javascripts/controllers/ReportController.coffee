controllers = angular.module('controllers')
controllers.controller("ReportController", [ '$scope', '$routeParams', '$resource', '$location', 'flash'
	($scope, $routeParams, $resource, $location, flash)->

		Report = $resource('/reports/:reportId', { reportId: "@id", format: 'json' })

		Report.get({reportId: $routeParams.reportId},
			( (report)-> $scope.report = report ),
			( (httpResponse)-> 
				$scope.report = null 
				flash.error = "There is no report with ID #{$routeParams.reportId}" 
				console.log 'no'
			)
		)

		$scope.back = -> $location.path("/")

])