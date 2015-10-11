angular.module 'adminPanel.dashBoardCtrl',[]
.controller 'dashBoardController',['$scope','store','$state',($scope,store,$state)->
  $scope.$on('$viewContentLoaded', ()->
    $ ".button-collapse"
    .sideNav();
  );
  $scope.logout = ->
    store.remove 'user'
    $state.go 'auth'
    Materialize.toast 'You have been logged out', 4000
]