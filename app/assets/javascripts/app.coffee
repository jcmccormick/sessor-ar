sessor = angular.module('sessor', [
  'templates',
  'ngRoute',
  'controllers'
])

sessor.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/',
        templateUrl: "index.html"
        controller: 'ReportsController'
      )
])

reports = [
	{
		id: 1
		name: 'Baked Potato w/ Cheese'
	},
	{
		id: 2
		name: 'Garlic Mashed Potatoes',
	},
	{
		id: 3
		name: 'Potatoes Au Gratin',
	},
	{
	    id: 4
	    name: 'Baked Brussel Sprouts',
	}
]

controllers = angular.module('controllers',[])
controllers.controller("ReportsController", [ '$scope', '$routeParams', '$location',
	($scope, $routeParams, $location)->
		$scope.search = (keywords)->  $location.path("/").search('keywords',keywords)
		if $routeParams.keywords
			keywords = $routeParams.keywords.toLowerCase()
			$scope.reports = reports.filter (report)-> report.name.toLowerCase().indexOf(keywords) != -1
		else
			$scope.reports = []
])
