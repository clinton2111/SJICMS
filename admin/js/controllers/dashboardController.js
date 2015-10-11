angular.module('adminPanel.dashBoardCtrl', []).controller('dashBoardController', [
  '$scope', 'store', '$state', function($scope, store, $state) {
    $scope.$on('$viewContentLoaded', function() {
      return $(".button-collapse").sideNav();
    });
    return $scope.logout = function() {
      store.remove('user');
      $state.go('auth');
      return Materialize.toast('You have been logged out', 4000);
    };
  }
]);
