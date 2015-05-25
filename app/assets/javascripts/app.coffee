sessor = angular.module('sessor', [
])

$(document).on('ready page:load', ->
  angular.bootstrap(document, ['sessor'])
)