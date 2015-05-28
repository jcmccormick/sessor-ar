controllers = angular.module('controllers')
controllers.controller("ReportController",  [ '$scope', '$routeParams', '$resource', '$location', '$localStorage', 'flash', 'ReportFactory',
	($scope, $routeParams, $resource, $location, $localStorage, flash, ReportFactory)->
		$scope.$storage = $localStorage
		$scope.reports = []
		$scope.report = []
		$scope.$storage.reports = $scope.reports
		$scope.$storage.report = $scope.report

		if $routeParams.reportId
			$scope.report = new ReportFactory()
			ReportFactory.get({id: $routeParams.reportId},
				(result)-> result.$promise.then((result)-> $scope.report = result)
			)

			console.log $scope.report

			# $scope.report = ReportFactory.get({id: $routeParams.reportId})
		else
			$scope.report = new ReportFactory()

		$scope.reports = ReportFactory.query()


		$scope.view      = (reportId)-> $location.path("/reports/#{reportId}")
		$scope.edit      = (reportId)-> $location.path("/reports/#{reportId}/edit")

		$scope.save      = ->
			if $routeParams.reportId
				$scope.report.$update({id: $routeParams.reportId},
				((response)->
					console.log response
					$location.path("/reports/#{$scope.report.id}")),
				((response)->
					console.log response
					flash.error = "Could not update"))
			else
				$scope.report.$save({},
				((response)->
					console.log response
					$location.path("/reports/#{response.id}")),
				((response)->
					console.log response
					flash.error = "Unable to create a new report"))

		$scope.delete = ()->
			$scope.report.$delete({id: $routeParams.reportId},
			(success)->
				delete $scope.$storage.report
				$location.path("/reports")
			(errors)->
				console.log errors.data
			)
])