directives = angular.module('directives')
directives.directive('templateFieldDirective', ['$http', '$compile',
($http, $compile) ->
  getTemplateUrl = (field) ->
    type = field.field_type
    templateUrl = 'template/directive-templates/field/'
    supported_fields = [
      'textfield'
      'email'
      'textarea'
      'checkbox'
      'date'
      'dropdown'
      'hidden'
      'password'
      'radio'
    ]
    if __indexOf.call(supported_fields, type) >= 0
      return templateUrl += type + '.html'
    return

  linker = (scope, element) ->
    # GET template content from path
    templateUrl = getTemplateUrl(scope.field)
    $http.get(templateUrl).success (data) ->
      element.html data
      $compile(element.contents()) scope
      return
    return

  {
    template: '<div>{{field}}</div>'
    restrict: 'E'
    scope: field: '='
    link: linker
  }
])