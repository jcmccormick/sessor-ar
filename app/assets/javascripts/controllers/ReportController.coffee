controllers = angular.module('controllers')
controllers.controller("ReportController", [ '$scope', '$routeParams', '$resource', 'flash'
	($scope,$routeParams,$resource,flash)->
		Report = $resource('/reports/:reportId', { reportId: "@id", format: 'json' })

		Report.get({reportId: $routeParams.reportId},
			( (report)-> $scope.report = report ),
			( (httpResponse)-> 
				$scope.report = null 
				flash.error = "There is no report with ID #{$routeParams.reportId}" 
			)
		)
])