describe "ReportsController", ->
  scope        = null
  ctrl         = null
  location     = null
  routeParams  = null
  resource     = null
  httpBackend  = null

  setupController = (keywords,results)->
    inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      httpBackend = $httpBackend
      routeParams = $routeParams
      routeParams.keywords = keywords
      
      if results
        request = new RegExp("\/reports.*keywords=#{keywords}")
        httpBackend.expectGET(request).respond(results)

      ctrl        = $controller('ReportsController',
                                $scope: scope
                                $location: location)
    )

  beforeEach(module("sessor"))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
    describe 'when no keywords present', ->
      beforeEach(setupController())
     
      it 'defaults to no reports', ->
        expect(scope.reports).toEqual([])

    describe 'with keywords', ->
      keywords = 'foo'
      reports = [
        {
          id: 2
          name: 'Baked Potatoes'
        },
        {
          id: 4
          name: 'Potatoes Au Gratin'
        }
      ]
      beforeEach ->
        setupController(keywords,reports)
        httpBackend.flush()

      it 'calls the back-end', ->
        expect(angular.equals(scope.reports, reports)).toBe(true)

    describe 'search()', ->
      beforeEach ->
        setupController()

      it 'redirects to itself with a keyword param', ->
        keywords = 'foo'
        scope.search(keywords)
        expect(location.path()).toBe('/')
        expect(location.search()).toEqual({keywords: keywords})