sessor = angular.module('sessor', [
  'templates',
  'ngRoute',
  'ngResource',
  'ngStorage',
  'controllers',
  'factories',
  'directives',
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
        controller: 'ReportController'
      )
      .when('/reports/new/',
        templateUrl: "edit_report.html"
        controller: 'ReportController'
      )
      .when('/reports/:reportId',
        templateUrl: "show_report.html"
        controller: 'ReportController'
      )
      .when('/reports/:reportId/edit',
        templateUrl: "edit_report.html"
        controller: 'ReportController'
      )
      .when('/template',
        templateUrl: "template.html"
        controller: 'TemplateController'
      )
      .when('/draggable',
        templateUrl: "draggable.html"
      )
])

controllers = angular.module('controllers',[])
factories   = angular.module('factories',[])
directives  = angular.module('directives',[])
