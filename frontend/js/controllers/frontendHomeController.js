angular.module('frontend.main').controller('frontendHomeController', [
  '$scope', function($scope) {
    return $scope.$on('$viewContentLoaded', function() {
      return $('.slider').slider({
        full_width: true,
        height: 800
      });
    });
  }
]);
