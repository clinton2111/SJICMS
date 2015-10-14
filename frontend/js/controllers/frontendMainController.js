angular.module('frontend.main', []).controller('frontendMainController', [
  '$scope', function($scope) {
    return $scope.$on('$viewContentLoaded', function() {
      return $(".button-collapse").sideNav();
    });
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
