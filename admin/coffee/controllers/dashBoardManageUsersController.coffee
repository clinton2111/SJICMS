angular.module 'dashboard.settingsCtrl'
.controller 'dashBoardManageUsersController', ['$scope', 'settingsFactory', 'md5', 'store',
  ($scope, settingsFactory, md5, store)->
    $scope.$on('$viewContentLoaded', ()->
      $('select').material_select();
    );
    $scope.users = []
    $scope.roles = [
      {
        value: 'admin',
        label: 'Administrator'
      }, {
        value: 'content_manager'
        label: 'Content Manager'
      }
    ]
    user = store.get 'user'
    $scope.createuser = ()->
      if (_.isNull($scope.newuser.role) or _.isEmpty($scope.newuser.role) or _.isUndefined($scope.newuser.role))
        Materialize.toast 'Please assign a role', 4000
        return false

      $scope.newuser.role = $scope.newuser.role.value;
      $scope.newuser.passEncrypted = md5.createHash($scope.newuser.password || '')
      settingsFactory.addUser($scope.newuser)
      .then (data)->
        response = data.data
        if response.status is 'Success'
          Materialize.toast response.status + " - " + response.message, 4000
          $scope.users.push(
            id
          )
        else
          Materialize.toast response.status + " - " + response.message, 4000
      , (error)->
        Materialize.toast('Something went wrong', 4000);

    $scope.fetchAdminDetails=->
      settingsFactory.fetchAdminDetails()
      .then (data)->
        response = data.data
        if response.status is 'Success'
          temp = response.results
          _.each temp, (index)->
            $scope.users.push index
          console.log $scope.users
          Materialize.toast response.status + " - " + response.message, 4000
        else
          Materialize.toast response.status + " - " + response.message, 4000
      , (error)->
        Materialize.toast('Something went wrong', 4000);

    $scope.deletePerson = (index)->
      data =
        id_to_be_deleted: $scope.users[index].id
        my_id: user.id
      settingsFactory.deletePerson(data)
      .then (data)->
        response = data.data
        if response.status is 'Success'
          $scope.users.splice(index, 1)
          Materialize.toast response.status + " - " + response.message, 4000
        else
          Materialize.toast response.status + " - " + response.message, 4000
      , (error)->
        Materialize.toast('Something went wrong', 4000);


]