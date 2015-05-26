controllers = angular.module('controllers')
controllers.controller("ReportsController", [ '$scope', '$routeParams', '$location', '$resource', 'flash'
	($scope, $routeParams, $location, $resource, flash)->
		$scope.search = (keywords)->  $location.path("/reports/").search('keywords',keywords)
		Report = $resource('/reports/:reportId', { reportId: "@id", format: 'json' })

		if $routeParams.keywords
			Report.query(keywords: $routeParams.keywords, 
				(results)-> 
					console.log results
					if results.length <= 0
						flash.error = "Sorry, no results for "+$routeParams.keywords
					else
						$scope.reports = results)
		else
			Report.query((results)-> $scope.reports = results)

		$scope.back      = -> $location.path("/reports")
		$scope.view      = (reportId)-> $location.path("/reports/#{reportId}")
		$scope.newReport = -> $location.path("/reports/new/")
		$scope.edit      = (reportId)-> $location.path("/reports/#{reportId}/edit/")
])