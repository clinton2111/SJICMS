angular.module 'frontend.main'
.controller 'frontendPagesController', ['$scope', 'fetcherFactory', '$state', ($scope, fetcherFactory, $state)->
  $scope.showLoader = false;
  offset = 0
  $scope.pages = null;

  $scope.fetchPages = ->
    now = moment().format("YYYY-MM-DD h:mm:ss a")
    $scope.showLoader = true;
    fetcherFactory.fetchpages(offset, now)
    .then (data)->
      if data.data.status is 'Success'
        if offset is 0
          $scope.pages = JSON.parse(data.data.results);
        else
          $scope.pages = $scope.pages.concat(JSON.parse(data.data.results))
        offset = $scope.pages.length;
        Materialize.toast 'Pages Loaded', '4000'
      else
        Materialize.toast data.data.message, '4000'
    , (error)->
      Materialize.toast('Something went wrong', 4000);
    .finally ()->
      $scope.showLoader = false;

  $scope.loadMore = ->
    $scope.fetchPages()
]
.filter 'unique', ->
  (collection, keyname) ->
    output = []
    keys = []
    angular.forEach collection, (item) ->
      key = item[keyname]
      if keys.indexOf(key) == -1
        keys.push key
        output.push item

    output
