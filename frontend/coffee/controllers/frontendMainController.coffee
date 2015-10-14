angular.module 'frontend.main', []
.controller 'frontendMainController', ['$scope', 'fetcherFactory', '$state', ($scope, fetcherFactory, $state)->
  $scope.$on '$viewContentLoaded', ->
    $ ".button-collapse"
    .sideNav();

  $scope.searchPosts = ->
    fetcherFactory.fetchSearchResults($scope.search.query, moment().format("YYYY-MM-DD h:mm:ss a"))
    .then (data)->
      if(data.data.status is 'Success')
        temp_storage = JSON.parse(data.data.results);
        #        console.log temp_storage
        $state.go('home.searchResults', {query: $scope.search.query, results: JSON.stringify(temp_storage)})
      else
        Materialize.toast(data.data.message, 4000);
    , (error)->
      Materialize.toast('Something went wrong', 4000);

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