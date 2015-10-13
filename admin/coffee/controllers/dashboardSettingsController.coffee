angular.module 'dashboard.settingsCtrl', []
.controller 'dashBoardSettingsController', ['$scope', 'md5', 'settingsFactory', ($scope, md5, settingsFactory)->
  $scope.updatePassword = (password)->
    if password.new != password.confirm then Materialize.toast('New password and confirmation password do not match',
      4000)
    else
      data =
        currentPassword: md5.createHash(password.current || '')
        newPassword: md5.createHash(password.new || '')
        id: $scope.user.id
      settingsFactory.updatePassword(data)
      .then (data)->
        response = data.data
        if response.status is 'Success'
          Materialize.toast response.status + " - " + response.message, 4000
        else
          Materialize.toast response.status + " - " + response.message, 4000
      , (error)->
        Materialize.toast('Something went wrong', 4000);

]