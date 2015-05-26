describe "ReportController", ->
  scope        = null
  ctrl         = null
  routeParams  = null
  httpBackend  = null
  flash        = null
  location     = null
  reportId     = 42

  fakeReport   =
    id: reportId
    name: "Baked Potatoes"
    submission: "Pierce potato with fork, nuke for 20 minutes"

  setupController =(reportExists=true, reportId=42)->
    inject(($location, $routeParams, $rootScope, $httpBackend, $controller, _flash_)->
      scope       = $rootScope.$new()
      location    = $location
      httpBackend = $httpBackend
      routeParams = $routeParams
      routeParams.reportId = reportId if reportId
      flash = _flash_

      if reportId
        request = new RegExp("\/reports/#{reportId}")
        results = if reportExists
          [200,fakeReport]
        else
          [404]
        httpBackend.expectGET(request).respond(results[0],results[1])
      ctrl        = $controller('ReportController',
                                $scope: scope)
    )

  beforeEach(module("sessor"))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()
  describe 'controller initialization', ->
    describe 'report is found', ->
      beforeEach(setupController())
      it 'loads the given report', ->
        httpBackend.flush()
        expect(angular.equals(scope.report, fakeReport)).toBe(true)
    describe 'report is not found', ->
      beforeEach(setupController(false))
      it 'loads the given report', ->
        httpBackend.flush()
        expect(scope.report).toBe(null)
        expect(flash.error).toBe("There is no report with ID #{reportId}")