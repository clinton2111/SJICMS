angular.module 'frontend.main'
.controller 'frontendHomeController', ['$scope', ($scope)->
  $scope.$on '$viewContentLoaded', ->
    $('.slider').slider({full_width: true, height: 800});

]