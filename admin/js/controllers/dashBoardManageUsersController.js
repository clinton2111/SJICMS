angular.module('dashboard.settingsCtrl').controller('dashBoardManageUsersController', [
  '$scope', 'settingsFactory', 'md5', function($scope, settingsFactory, md5) {
    $scope.$on('$viewContentLoaded', function() {
      return $('select').material_select();
    });
    $scope.roles = [
      {
        value: 'admin',
        label: 'Administrator'
      }, {
        value: 'content_manager',
        label: 'Content Manager'
      }
    ];
    return $scope.createuser = function() {
      $scope.newuser.role = $scope.newuser.role.value;
      $scope.newuser.passEncrypted = md5.createHash($scope.newuser.password || '');
      console.log($scope.newuser);
      return settingsFactory.addUser($scope.newuser).then(function(data) {
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
    };
  }
]);
