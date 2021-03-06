angular.module('adminPanel.dashBoardCtrl', []).controller('dashBoardController', [
  '$scope', 'store', '$state', function($scope, store, $state) {
    $scope.$on('$viewContentLoaded', function() {
      return $(".button-collapse").sideNav();
    });
    $scope.user = store.get('user');
    return $scope.logout = function() {
      store.remove('user');
      $state.go('auth', {
        type: 'login',
        email: null,
        value: null
      });
      return Materialize.toast('You have been logged out', 4000);
    };
  }
]);
