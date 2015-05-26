sessor = angular.module('sessor', [
  'templates',
  'ngRoute',
  'ngResource',
  'angular-flash.service',
  'angular-flash.flash-alert-directive',
  'controllers'
])

sessor.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/',
        templateUrl: "index.html"
        controller: 'ReportsController'
      ).when('/reports/:reportId',
        templateURL: "show.html",
        controller: 'ReportController'
      )
])

controllers = angular.module('controllers',[])