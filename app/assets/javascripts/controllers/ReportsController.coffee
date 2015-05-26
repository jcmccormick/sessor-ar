controllers = angular.module('controllers')
controllers.controller("ReportsController", [ '$scope', '$routeParams', '$location', '$resource',
	($scope, $routeParams, $location, $resource)->
		Report = $resource('/reports/:reportId', { reportId: "@id", format: 'json' })

		$scope.search = (keywords)->  $location.path("/").search('keywords',keywords)
		
		if $routeParams.keywords
			Report.query(keywords: $routeParams.keywords, (results)-> $scope.reports = results)
		else
			$scope.reports = []
])