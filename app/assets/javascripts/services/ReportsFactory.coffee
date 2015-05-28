factories = angular.module('factories')
factories.factory("ReportsFactory", [ '$resource'
  ($resource)->
    $resource('/reports/:id')
])