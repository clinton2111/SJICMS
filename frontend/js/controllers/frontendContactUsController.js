angular.module('frontend.main').controller('frontendContactUsController', [
  '$scope', 'ContactFactory', function($scope, ContactFactory) {
    return $scope.sendEmail = function() {
      $scope.email.now = moment().format("YYYY-MM-DD h:mm:ss a");
      return ContactFactory.sendEmail($scope.email).then(function(data) {
        var response;
        response = data.data;
        if (response.status === 'Success') {
          Materialize.toast(response.status + ' - ' + response.message, 4000);
          return $scope.email = {};
        } else {
          return Materialize.toast(response.status + ' - ' + response.message, 4000);
        }
      }, function(error) {
        return Materialize.toast('Opps something went wrong.', 4000);
      });
    };
  }
]);
