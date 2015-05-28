controllers = angular.module('controllers')
controllers.controller('TemplateController', [ '$scope', '$resource',
	($scope, $resource)->
		$scope.fieldToBeAdded = []
		$scope.box = []

		$scope.fieldTypes = {
			0:{name: 'button'}
			1:{name: 'checkbox'}
		}

		console.log $scope.fieldTypes

		$scope.box = {
			"id": "0001"
			"type": "table"
			"name": "User Feedback Survey"
			"image":
				{
					"url": "images/0001.jpg"
					"width": 200
					"height": 200
				}
			"thumbnail":
				{
					"url": "images/thumbnails/0001.jpg"
					"width": 32
					"height": 32
				}
		}

		data = {"formfield", "value"}

		console.log $scope.box.image
])