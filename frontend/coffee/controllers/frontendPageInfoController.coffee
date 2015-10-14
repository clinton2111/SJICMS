angular.module 'frontend.main'
.controller 'frontendPageInfoController', ['$scope', 'fetcherFactory', '$stateParams',
  ($scope, fetcherFactory, $stateParams)->
    $scope.showLoader = false;
    $scope.fetchPageInfo = ->
      now = moment().format("YYYY-MM-DD h:mm:ss a")
      $scope.showLoader = true;
      id = $stateParams.id
      fetcherFactory.fetchPageInfo(id)
      .then (data)->
        console.log data.data
#        if data.data.status is 'Success'
#
#          $scope.pages = JSON.parse(data.data.results);
#          Materialize.toast 'Page Loaded', '4000'
#        else if data.data.status is 'Scheduled'
#
#
#        else if data.data.status is '404'
#          Materialize.toast data.data.message, '4000'
      , (error)->
        Materialize.toast('Something went wrong', 4000);
      .finally ()->
        $scope.showLoader = false;
]