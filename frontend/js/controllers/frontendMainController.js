angular.module('frontend.main', []).controller('frontendMainController', [
  '$scope', function($scope) {
    return $scope.$on('$viewContentLoaded', function() {
      return $(".button-collapse").sideNav();
    });
  }
]);
