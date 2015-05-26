describe "ReportsController", ->
  scope        = null
  ctrl         = null
  location     = null
  routeParams  = null
  resource     = null

  setupController = (keywords)->
    inject(($location, $routeParams, $rootScope, $resource, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      routeParams = $routeParams
      routeParams.keywords = keywords

      ctrl        = $controller('ReportsController',
                                $scope: scope
                                $location: location)
    )

  beforeEach(module("sessor"))
  beforeEach(setupController())

  it 'defaults to no reports', ->
    expect(scope.reports).toEqual([])