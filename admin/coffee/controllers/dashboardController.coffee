angular.module 'adminPanel.dashBoardCtrl',[]
.controller 'dashBoardController',['$scope','store','$state',($scope,store,$state)->
  $scope.$on('$viewContentLoaded', ()->
    $ ".button-collapse"
    .sideNav();
  );

  $scope.user = store.get 'user'

  $scope.logout = ->
    store.remove 'user'
    $state.go 'auth', {type: 'login', email: null, value: null}
    Materialize.toast 'You have been logged out', 4000
]