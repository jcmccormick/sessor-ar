sessor = angular.module('sessor', [
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'factories',
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
      )
      .when('/reports',
        templateUrl: "show_reports.html"
        controller: 'ReportsController'
      )
      .when('/reports/new/',
        templateUrl: "edit_report.html"
        controller: 'ReportController'
      )
      .when('/reports/:reportId/',
        templateUrl: "show_report.html"
        controller: 'ReportController'
      )
      .when('/reports/:reportId/edit',
        templateUrl: "edit_report.html"
        controller: 'ReportController'
      )
])

controllers = angular.module('controllers',[])
factories   = angular.module('factories',[])

factories.factory( 'AuthServ', ["$cookieStore", '$http',
  currentUser: null
  ->
    login: (email, password, fn)->
      $cookieStore.put("currentUser", currentUser.name)
    logout: ()->
      currentUser = undefined
      $cookieStore.put("currentUser", currentUser)
    isLoggedIn: ()->
      return currentUser != undefined
])