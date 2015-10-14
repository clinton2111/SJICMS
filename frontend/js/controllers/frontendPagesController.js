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
    $scope.loadMore = function() {
      return $scope.fetchPages();
    };
    return $scope.formatDate = function(date) {
      return moment(date, 'YYYY-MM-DD h:mm:ss a').format('YYYY/MM/DD');
    };
  }
]);
