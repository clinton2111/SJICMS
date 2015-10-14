angular.module('frontend.main').controller('frontendSearchResultsController', [
  '$scope', '$stateParams', '$state', function($scope, $stateParams, $state) {
    $scope.query = $stateParams.query;
    return $scope.results = JSON.parse($stateParams.results);
  }
]);
