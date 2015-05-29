controllers = angular.module('controllers')
controllers.controller('TemplateController', [ '$scope', '$resource', 'ngDialog', 'TemplateService',
($scope, $resource, ngDialog, TemplateService)->
	# preview form mode
	$scope.previewMode = false
	# new form
	$scope.form = {}
	$scope.form.form_id = 1
	$scope.form.form_name = ''
	$scope.form.form_fields = []
	# previewForm - for preview purposes, form will be copied into this
	# otherwise, actual form might get manipulated in preview mode
	$scope.previewForm = {}
	# add new field drop-down:
	$scope.addField = {}
	$scope.addField.types = TemplateService.fields
	$scope.addField.new = $scope.addField.types[0].name
	$scope.addField.lastAddedID = 0
	# accordion settings
	$scope.accordion = {}
	$scope.accordion.oneAtATime = true
	# create new field button click

	$scope.addNewField = (type)->
		console.log(type)
		$scope.addField.lastAddedID++
		newField = 
			'field_id': $scope.addField.lastAddedID
			'field_title': $scope.addField.lastAddedID + ' ' + type + ' field '
			'field_type': type
			'field_value': ''
			'field_required': true
			'field_disabled': false
		# put newField into fields array
		$scope.form.form_fields.push newField
		return

	# deletes particular field on button click

	$scope.deleteField = (field_id) ->
		i = 0
		while i < $scope.form.form_fields.length
			if $scope.form.form_fields[i].field_id == field_id
				$scope.form.form_fields.splice i, 1
				break
			i++
		return

	# add new option to the field

	$scope.addOption = (field) ->
		if !field.field_options
			field.field_options = new Array
		lastOptionID = 0
		if field.field_options[field.field_options.length - 1]
			lastOptionID = field.field_options[field.field_options.length - 1].option_id
		# new option's id
		option_id = lastOptionID + 1
		newOption = 
			'option_id': option_id
			'option_title': 'Option ' + option_id
			'option_value': option_id
		# put new option into field_options array
		field.field_options.push newOption
		return

	# delete particular option

	$scope.deleteOption = (field, option) ->
		i = 0
		while i < field.field_options.length
			if field.field_options[i].option_id == option.option_id
				field.field_options.splice i, 1
				break
			i++
		return

	# preview form

	$scope.previewOn = ->
		if $scope.form.form_fields == null or $scope.form.form_fields.length == 0
			title = 'Error'
			msg = 'No fields added yet, please add fields to the form before preview.'
			btns = [ {
				result: 'ok'
				label: 'OK'
				cssClass: 'btn-primary'
			} ]
			ngDialog.open(title, msg, btns)
		else
			$scope.previewMode = !$scope.previewMode
			$scope.form.submitted = false
			angular.copy $scope.form, $scope.previewForm
		return

	# hide preview form, go back to create mode

	$scope.previewOff = ->
		$scope.previewMode = !$scope.previewMode
		$scope.form.submitted = false
		return

	# decides whether field options block will be shown (true for dropdown and radio fields)

	$scope.showAddOptions = (field) ->
		if field.field_type == 'radio' or field.field_type == 'dropdown'
			true
		else
			false

	# deletes all the fields

	$scope.reset = ->
		$scope.form.form_fields.splice 0, $scope.form.form_fields.length
		$scope.addField.lastAddedID = 0
		return

	# ui-bootstrap accordion
	$scope.oneAtATime = true
	$scope.groups = [
		{
			title: 'Dynamic Group Header - 1'
			content: 'Dynamic Group Body - 1'
		}
		{
			title: 'Dynamic Group Header - 2'
			content: 'Dynamic Group Body - 2'
		}
	]
	$scope.items = [
		'Item 1'
		'Item 2'
		'Item 3'
	]

	$scope.addItem = ->
		newItemNo = $scope.items.length + 1
		$scope.items.push 'Item ' + newItemNo
		return

	$scope.status =
		isFirstOpen: true
		isFirstDisabled: false
])