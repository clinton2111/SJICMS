angular.module('dashboard.settingsCtrl', []).controller('dashBoardSettingsController', [
  '$scope', 'md5', 'settingsFactory', '$state', function($scope, md5, settingsFactory, $state) {
    $scope.updatePassword = function(password) {
      var data;
      if (password["new"] !== password.confirm) {
        return Materialize.toast('New password and confirmation password do not match', 4000);
      } else {
        data = {
          currentPassword: md5.createHash(password.current || ''),
          newPassword: md5.createHash(password["new"] || ''),
          id: $scope.user.id
        };
        return settingsFactory.updatePassword(data).then(function(data) {
          var response;
          response = data.data;
          if (response.status === 'Success') {
            return Materialize.toast(response.status + " - " + response.message, 4000);
          } else {
            return Materialize.toast(response.status + " - " + response.message, 4000);
          }
        }, function(error) {
          return Materialize.toast('Something went wrong', 4000);
        });
      }
    };
    return $scope.openAdminPage = function() {
      return $state.go('dashboard.manageUsers');
    };
  }
]);
