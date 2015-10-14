angular.module('frontend.main').controller('frontendPageInfoController', [
  '$scope', 'fetcherFactory', '$stateParams', function($scope, fetcherFactory, $stateParams) {
    $scope.showLoader = false;
    return $scope.fetchPageInfo = function() {
      var id, now;
      now = moment().format("YYYY-MM-DD h:mm:ss a");
      $scope.showLoader = true;
      id = $stateParams.id;
      return fetcherFactory.fetchPageInfo(id).then(function(data) {
        return console.log(data.data);
      }, function(error) {
        return Materialize.toast('Something went wrong', 4000);
      })["finally"](function() {
        return $scope.showLoader = false;
      });
    };
  }
]);
