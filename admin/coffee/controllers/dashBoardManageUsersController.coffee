angular.module 'dashboard.settingsCtrl'
.controller 'dashBoardManageUsersController', ['$scope', 'settingsFactory', 'md5', ($scope, settingsFactory, md5)->
  $scope.$on('$viewContentLoaded', ()->
    $('select').material_select();
  );
  $scope.roles = [
    {
      value: 'admin',
      label: 'Administrator'
    }, {
      value: 'content_manager'
      label: 'Content Manager'
    }
  ]
  $scope.createuser = ()->
    $scope.newuser.role = $scope.newuser.role.value;
    $scope.newuser.passEncrypted = md5.createHash($scope.newuser.password || '')
    console.log $scope.newuser
    settingsFactory.addUser($scope.newuser)
    .then (data)->
      response = data.data
      if response.status is 'Success'
        Materialize.toast response.status + " - " + response.message, 4000
      else
        Materialize.toast response.status + " - " + response.message, 4000
    , (error)->
      Materialize.toast('Something went wrong', 4000);
]