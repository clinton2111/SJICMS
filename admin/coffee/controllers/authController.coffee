angular.module 'adminPanel.authentication', []
.controller 'authController', ['$scope', 'authFactory', 'md5', 'store', '$state',($scope, authFactory, md5, store,$state)->
  $scope.viewPass = false
  $scope.passType = 'password'
  $scope.passIcon = 'mdi-action-visibility-off'
  $scope.toggleShowPassword = ()->
    if ($scope.viewPass is false)
      $scope.viewPass = true
      $scope.passType = 'text'
      $scope.passIcon = 'mdi-action-visibility'
    else
      $scope.viewPass = false
      $scope.passType = 'password'
      $scope.passIcon = 'mdi-action-visibility-off'

  $scope.login = (user)->
    data =
      email: user.email
      password: md5.createHash(user.password || '')
    authFactory.login data
    .then (data)->
      userData = data.data
      if userData.status is 'Error'
        Materialize.toast userData.message, '4000'
      else
        userObj =
          id: userData.id
          token: userData.token
          username: userData.username
          lastUpdate: moment().format('DD-MM-YYYY')
        store.set 'user', userObj
        $state.go 'dashboard'
        Materialize.toast userData.message, '4000'
    , (error)->
      Materialize.toast error.data.message, '4000'

]