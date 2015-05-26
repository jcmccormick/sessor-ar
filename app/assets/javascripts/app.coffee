sessor = angular.module('sessor', [
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])

sessor.config([ '$routeProvider', 'flashProvider',
  ($routeProvider, flashProvider)->
      flashProvider.errorClassnames.push("alert-danger")
      flashProvider.warnClassnames.push("alert-warning")
      flashProvider.infoClassnames.push("alert-info")
      flashProvider.successClassnames.push("alert-success")

      $routeProvider
      .when('/',
        templateUrl: "index.html"
        controller: 'ReportsController'
      )
      .when('/reports/new',
        templateUrl: "form.html"
        controller: 'ReportController'
      )
      .when('/reports/:reportId',
        templateUrl: "show.html"
        controller: 'ReportController'
      )
      .when('/reports/:reportId/edit',
        templateUrl: "form.html"
        controller: 'ReportController'
      )
])

controllers = angular.module('controllers',[])