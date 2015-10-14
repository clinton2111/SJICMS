angular.module 'frontend.main', []
.controller 'frontendMainController', ['$scope', ($scope)->
  $scope.$on '$viewContentLoaded', ->
    $ ".button-collapse"
    .sideNav();

]