angular.module('adminPanel.authentication', []).controller('authController', [
  '$scope', 'authFactory', 'md5', 'store', '$state', function($scope, authFactory, md5, store, $state) {
    $scope.viewPass = false;
    $scope.passType = 'password';
    $scope.passIcon = 'mdi-action-visibility-off';
    $scope.toggleShowPassword = function() {
      if ($scope.viewPass === false) {
        $scope.viewPass = true;
        $scope.passType = 'text';
        return $scope.passIcon = 'mdi-action-visibility';
      } else {
        $scope.viewPass = false;
        $scope.passType = 'password';
        return $scope.passIcon = 'mdi-action-visibility-off';
      }
    };
    return $scope.login = function(user) {
      var data;
      data = {
        email: user.email,
        password: md5.createHash(user.password || '')
      };
      return authFactory.login(data).then(function(data) {
        var userData, userObj;
        userData = data.data;
        if (userData.status === 'Error') {
          return Materialize.toast(userData.message, '4000');
        } else {
          userObj = {
            id: userData.id,
            token: userData.token,
            username: userData.username,
            lastUpdate: moment().format('DD-MM-YYYY')
          };
          store.set('user', userObj);
          $state.go('dashboard');
          return Materialize.toast(userData.message, '4000');
        }
      }, function(error) {
        return Materialize.toast(error.data.message, '4000');
      });
    };
  }
]);
