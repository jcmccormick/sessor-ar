services = angular.module('services')
services.service('TemplateService', ['$http', 
($http) ->
  formsJsonPath = '.templates/template/static-data/sample_forms.json'
  {
    fields: [
      {
        name: 'textfield'
        value: 'Textfield'
      }
      {
        name: 'email'
        value: 'E-mail'
      }
      {
        name: 'password'
        value: 'Password'
      }
      {
        name: 'radio'
        value: 'Radio Buttons'
      }
      {
        name: 'dropdown'
        value: 'Dropdown List'
      }
      {
        name: 'date'
        value: 'Date'
      }
      {
        name: 'textarea'
        value: 'Text Area'
      }
      {
        name: 'checkbox'
        value: 'Checkbox'
      }
      {
        name: 'hidden'
        value: 'Hidden'
      }
    ]
    form: (id) ->
      # $http returns a promise, which has a then function, which also returns a promise
      $http.get(formsJsonPath).then (response) ->
        requestedForm = {}
        angular.forEach response.data, (form) ->
          if form.form_id == id
            requestedForm = form
          return
        requestedForm
    forms: ->
      $http.get(formsJsonPath).then (response) ->
        response.data

  }
])