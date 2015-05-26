controllers = angular.module('controllers')
controllers.controller("ReportsController", [ '$scope', '$routeParams', '$location', '$resource',
	($scope, $routeParams, $location, $resource)->
		$scope.search = (keywords)->  $location.path("/reports/").search('keywords',keywords)
		Report = $resource('/reports/:reportId', { reportId: "@id", format: 'json' })

		if $routeParams.keywords
			Report.query(keywords: $routeParams.keywords, (results)-> $scope.reports = results)
		else
			Report.query((results)-> $scope.reports = results)

		$scope.view      = (reportId)-> $location.path("/reports/#{reportId}")
		$scope.newReport = -> $location.path("/reports/new/")
		$scope.edit      = (reportId)-> $location.path("/reports/#{reportId}/edit/")
])