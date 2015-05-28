__indexOf = [].indexOf || (item)->
  i = 0
  for i in [0...this.length]
    if i in this && this[i] == item
      i++
      return i
  return -1

directives = angular.module('directives')
directives.directive('templateFieldDirective', ['$http', '$compile',
($http, $compile) ->
  getTemplate = (field) ->
    type = field.field_type
    supported_fields = [
      'textfield'
      'textarea'
      'email'
      'checkbox'
      'date'
      'dropdown'
      'hidden'
      'password'
      'radio'
    ]
    if __indexOf.call(supported_fields, type) >= 0
      return type
    return

  linker = (scope, element) ->

    textfield = '
    <div class="field row">
      <div class="span2">{{field.field_title}}:</div>
        <span class="required-error" ng-show="field.field_required && !field.field_value">* required </span>
        <div class="span4">
          <div class="control-group input-append">
            <input type="date" class="form-control" ng-model="field.field_value" data-date-format="mm/dd/yyyy" ng-required="field.field_required" ng-disabled="field.field_disabled">
          </div>
        </div>
      </div>
    </div>'

    textarea = '
    <div class="field row">
      <div class="span2">{{field.field_title}}:</div>
      <div class="span4">
        <textarea type="text" ng-model="field.field_value" value="{{field.field_value}}" ng-required="field.field_required" ng-disabled="field.field_disabled"></textarea>
        <span class="required-error" ng-show="field.field_required && !field.field_value">* required</span>
      </div>
    </div>'

    email = '
    <div class="field row">
      <div class="span2">{{field.field_title}}:</div>
      <div class="span4">
        <input type="email" placeholder="Email" value="{{field.field_value}}" ng-model="field.field_value" ng-required="field.field_required" ng-disabled="field.field_disabled"/>
        <span class="required-error" ng-show="field.field_required && !field.field_value">* required</span>
      </div>
    </div>'

    checkbox = '
    <br>
    <input ng-model="field.field_value" id="{{field.field_id}}" type="checkbox" ng-true-value="1" ng-false-value="0" ng-required="field.field_required" ng-disabled="field.field_disabled"/>
    <label class="form-field-label" for="{{field.field_id}}" ng-cloak>{{field.field_title}}</label>
    <span class="required-error" ng-show="field.field_required && field.field_value == 0">(* required)</span>'

    date = '
    <div class="field row">
      <div class="span2">{{field.field_title}}:</div>
      <span class="required-error" ng-show="field.field_required && !field.field_value">* required </span>
      <div class="span4">
        <div class="control-group input-append">
          <input type="text" ng-model="field.field_value" data-date-format="mm/dd/yyyy" bs-datepicker  ng-required="field.field_required" ng-disabled="field.field_disabled">
          <button type="button" class="btn" data-toggle="datepicker"></button>
        </div>
      </div>
    </div>'

    dropdown = '
    <div class="field row">
      <div class="span2">{{field.field_title}}:</div>
      <div class="span4">
        <select ng-model="field.field_value" ng-required="field.field_required" ng-disabled="field.field_disabled">
          <option ng-repeat="option in field.field_options" 
              ng-selected="option.option_value == field.field_value"
              value="{{option.option_id}}">
            {{option.option_title}}
          </option>
        </select>    
        <span class="required-error" ng-show="field.field_required && !field.field_value">* required</span>
      </div>
    </div>
    <br>'

    hidden = '
    <input type="hidden" ng-model="field.field_value" value="{{field.field_value}}" ng-disabled="field.field_disabled">'

    password = '
    <div class="field row">
      <div class="span2">{{field.field_title}}:</div>
      <div class="span4">
        <input type="password" ng-model="field.field_value" value="{{field.field_value}}"  ng-required="field.field_required" ng-disabled="field.field_disabled">
        <span class="required-error" ng-show="field.field_required && !field.field_value">* required</span>
      </div>
    </div>'

    radio = '
    <div class="field row">
      <div class="span2">{{field.field_title}}:</div>
      <div class="span4">
        <div ng-repeat="option in field.field_options" class="row-fluid">
          <label>
            <input type="radio" value="{{option.option_value}}" ng-model="field.field_value"  ng-required="field.field_required" ng-disabled="field.field_disabled"/>
            &nbsp;<span ng-bind="option.option_title"></span>
          </label>
        </div>
        <span class="required-error" ng-show="field.field_required && !field.field_value">* required</span>
      </div>
    </div>
    <br>'

    # GET template content from path
    template = getTemplate(scope.field)

    switch template
      when "textfield" then element.html textfield
      when "textarea" then element.html textarea
      when "email" then element.html email
      when "checkbox" then element.html checkbox
      when "date" then element.html date
      when "dropdown" then element.html dropdown
      when "hidden" then element.html hidden
      when "password" then element.html password
      when "radio" then element.html radio

    $compile(element.contents()) scope
    return

  {
    template: '<div>{{field}}</div>'
    restrict: 'E'
    scope: field: '='
    link: linker
  }
])