angular.module 'frontend.main'
.controller 'frontendPageInfoController', ['$scope', 'fetcherFactory', '$stateParams', '$state'
  ($scope, fetcherFactory, $stateParams, $state)->
    $scope.$on('$viewContentLoaded', ()->
      $('.tooltipped').tooltip({delay: 50});
    );

    $scope.showLoader = false;
    $scope.fetchPageInfo = ->
      now = moment().format("YYYY-MM-DD h:mm:ss a")
      $scope.showLoader = true;
      id = $stateParams.id
      fetcherFactory.fetchPageInfo(id, now)
      .then (data)->
        if data.data.status is 'Success'
          $scope.post = JSON.parse(data.data.results);
          Materialize.toast 'Page Loaded', '4000'
        else if data.data.status is 'Scheduled'
          $state.go 'home.later'
        else if data.data.status is '404'
          $state.go 'home.404'
      , (error)->
        Materialize.toast('Something went wrong', 4000);
      .finally ()->
        $scope.showLoader = false;

    $scope.openModal=()->
      $('#commentModal').openModal();

]