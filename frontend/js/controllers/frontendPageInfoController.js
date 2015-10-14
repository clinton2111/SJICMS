angular.module('frontend.main').controller('frontendPageInfoController', [
  '$scope', 'fetcherFactory', '$stateParams', '$state', function($scope, fetcherFactory, $stateParams, $state) {
    $scope.$on('$viewContentLoaded', function() {
      return $('.tooltipped').tooltip({
        delay: 50
      });
    });
    $scope.showLoader = false;
    $scope.fetchPageInfo = function() {
      var id, now;
      now = moment().format("YYYY-MM-DD h:mm:ss a");
      $scope.showLoader = true;
      id = $stateParams.id;
      return fetcherFactory.fetchPageInfo(id, now).then(function(data) {
        if (data.data.status === 'Success') {
          $scope.post = JSON.parse(data.data.results);
          return Materialize.toast('Page Loaded', '4000');
        } else if (data.data.status === 'Scheduled') {
          return $state.go('home.later');
        } else if (data.data.status === '404') {
          return $state.go('home.404');
        }
      }, function(error) {
        return Materialize.toast('Something went wrong', 4000);
      })["finally"](function() {
        return $scope.showLoader = false;
      });
    };
    return $scope.openModal = function() {
      return $('#commentModal').openModal();
    };
  }
]);
