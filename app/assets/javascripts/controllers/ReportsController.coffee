controllers = angular.module('controllers')
controllers.controller("ReportsController", [ '$scope', '$routeParams', '$location', '$resource',
	($scope, $routeParams, $location, $resource)->
		$scope.search = (keywords)->  $location.path("/").search('keywords',keywords)
		Report = $resource('/reports/:reportId', { reportId: "@id", format: 'json' })
		
		if $routeParams.keywords
			Report.query(keywords: $routeParams.keywords, (results)-> $scope.reports = results)
		else
			$scope.reports = []

		$scope.view = (reportId)-> $location.path("/reports/#{reportId}")
])