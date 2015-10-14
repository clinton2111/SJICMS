angular.module('frontend.main').controller('frontendPagesController', [
  '$scope', 'fetcherFactory', '$state', function($scope, fetcherFactory, $state) {
    var offset;
    $scope.showLoader = false;
    offset = 0;
    $scope.pages = null;
    $scope.fetchPages = function() {
      var now;
      now = moment().format("YYYY-MM-DD h:mm:ss a");
      $scope.showLoader = true;
      return fetcherFactory.fetchpages(offset, now).then(function(data) {
        if (data.data.status === 'Success') {
          if (offset === 0) {
            $scope.pages = JSON.parse(data.data.results);
          } else {
            $scope.pages = $scope.pages.concat(JSON.parse(data.data.results));
          }
          offset = $scope.pages.length;
          return Materialize.toast('Pages Loaded', '4000');
        } else {
          return Materialize.toast(data.data.message, '4000');
        }
      }, function(error) {
        return Materialize.toast('Something went wrong', 4000);
      })["finally"](function() {
        return $scope.showLoader = false;
      });
    };
    return $scope.loadMore = function() {
      return $scope.fetchPages();
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
});
