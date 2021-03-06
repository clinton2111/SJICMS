angular.module('dashboard.settingsCtrl').controller('dashBoardManageUsersController', [
  '$scope', 'settingsFactory', 'md5', 'store', function($scope, settingsFactory, md5, store) {
    var user;
    $scope.$on('$viewContentLoaded', function() {
      return $('select').material_select();
    });
    $scope.users = [];
    $scope.roles = [
      {
        value: 'admin',
        label: 'Administrator'
      }, {
        value: 'content_manager',
        label: 'Content Manager'
      }
    ];
    user = store.get('user');
    $scope.createuser = function() {
      if (_.isNull($scope.newuser.role) || _.isEmpty($scope.newuser.role) || _.isUndefined($scope.newuser.role)) {
        Materialize.toast('Please assign a role', 4000);
        return false;
      }
      $scope.newuser.role = $scope.newuser.role.value;
      $scope.newuser.passEncrypted = md5.createHash($scope.newuser.password || '');
      return settingsFactory.addUser($scope.newuser).then(function(data) {
        var response;
        response = data.data;
        if (response.status === 'Success') {
          Materialize.toast(response.status + " - " + response.message, 4000);
          return $scope.users.push(id);
        } else {
          return Materialize.toast(response.status + " - " + response.message, 4000);
        }
      }, function(error) {
        return Materialize.toast('Something went wrong', 4000);
      });
    };
    $scope.fetchAdminDetails = function() {
      return settingsFactory.fetchAdminDetails().then(function(data) {
        var response, temp;
        response = data.data;
        if (response.status === 'Success') {
          temp = response.results;
          _.each(temp, function(index) {
            return $scope.users.push(index);
          });
          console.log($scope.users);
          return Materialize.toast(response.status + " - " + response.message, 4000);
        } else {
          return Materialize.toast(response.status + " - " + response.message, 4000);
        }
      }, function(error) {
        return Materialize.toast('Something went wrong', 4000);
      });
    };
    return $scope.deletePerson = function(index) {
      var data;
      data = {
        id_to_be_deleted: $scope.users[index].id,
        my_id: user.id
      };
      return settingsFactory.deletePerson(data).then(function(data) {
        var response;
        response = data.data;
        if (response.status === 'Success') {
          $scope.users.splice(index, 1);
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
