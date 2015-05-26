controllers = angular.module('controllers')
controllers.controller("ReportController", [ '$scope', '$routeParams', '$resource', '$location', 'flash'
	($scope, $routeParams, $resource, $location, flash)->

		Report = $resource('/reports/:reportId', { reportId: "@id", format: 'json' },
			{
				'save':   {method:'PUT'},
				'create': {method:'POST'}
			}
		)

		if $routeParams.reportId
			Report.get({reportId: $routeParams.reportId},
				( (report)-> $scope.report = report ),
				( (httpResponse)-> 
					$scope.report = null 
					flash.error   = "There is no report with ID #{$routeParams.reportId}"
				)
			)
		else
			$scope.report = {}

		$scope.back   = -> $location.path("/")
		$scope.edit   = -> $location.path("/reports/#{$scope.report.id}/edit")
		$scope.cancel = ->
			if $scope.report.id
				$location.path("/reports/#{$scope.report.id}")
			else
				$location.path("/")

		$scope.save = ->
			onError = (_httpResponse)-> flash.error = "Something went wrong"
			if $scope.report.id
				$scope.report.$save(
					( ()-> $location.path("/reports/#{$scope.report.id}") ),
					onError)
			else
				Report.create($scope.report,
					( (newReport)-> $location.path("/reports/#{newReport.id}") ),
					onError
				)

		$scope.delete = ->
			$scope.report.$delete()
			$scope.back()
])