angular.module('frontend.main', []).controller('frontendMainController', [
  '$scope', 'fetcherFactory', '$state', function($scope, fetcherFactory, $state) {
    $scope.$on('$viewContentLoaded', function() {
      return $(".button-collapse").sideNav();
    });
    return $scope.searchPosts = function() {
      return fetcherFactory.fetchSearchResults($scope.search.query, moment().format("YYYY-MM-DD h:mm:ss a")).then(function(data) {
        var temp_storage;
        if (data.data.status === 'Success') {
          temp_storage = JSON.parse(data.data.results);
          return $state.go('home.searchResults', {
            query: $scope.search.query,
            results: JSON.stringify(temp_storage)
          });
        } else {
          return Materialize.toast(data.data.message, 4000);
        }
      }, function(error) {
        return Materialize.toast('Something went wrong', 4000);
      });
    };
  }
]).filter('unique', function() {
  return function(collection, keyname) {
    var keys, output;
    output = [];
    keys = [];
    angular.forEach(collection, function(item) {
      var key;
      key = item[keyname];
      if (keys.indexOf(key) === -1) {
        keys.push(key);
        return output.push(item);
      }
    });
    return output;
  };
}).filter("myDate", function() {
  return function(input) {
    if (input) {
      return moment(input, 'YYYY-MM-DD h:mm:ss a').format("dddd, MMMM Do YYYY, h:mm a");
    }
  };
});
