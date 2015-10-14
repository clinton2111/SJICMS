angular.module 'frontend.main'
.controller 'frontendSearchResultsController', ['$scope', '$stateParams', '$state', ($scope, $stateParams, $state)->
  $scope.query = $stateParams.query
  $scope.results = JSON.parse($stateParams.results)
]
