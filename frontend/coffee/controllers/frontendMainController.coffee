angular.module 'frontend.main', []
.controller 'frontendMainController', ['$scope', ($scope)->
  $scope.$on '$viewContentLoaded', ->
    $ ".button-collapse"
    .sideNav();

]
.filter 'unique', ->
  (collection, keyname) ->
    output = []
    keys = []
    angular.forEach collection, (item) ->
      key = item[keyname]
      if keys.indexOf(key) == -1
        keys.push key
        output.push item

    output
.filter "myDate", ()->
  (input)->
    if input then moment(input, 'YYYY-MM-DD h:mm:ss a').format("dddd, MMMM Do YYYY, h:mm a")