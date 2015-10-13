angular.module 'adminPanel.authentication'
.factory 'authFactory', ['$http', '$q', 'API', ($http, $q, API)->
  return(
    login: (userCredentials)->
      userCredentials.type = 'login'
      q = $q.defer()
      $http
        url: API.url + 'auth.php'
        method: 'POST'
        data: userCredentials
        skipAuthorization: true
      .then (data)->
        q.resolve data
      , (error)->
        q.reject(error)

      q.promise

    recoverPassword: (emailData)->
      emailData.type = 'recoverPassword'
      q = $q.defer()
      $http
        url: API.url + 'auth.php'
        method: 'POST'
        data: emailData
        skipAuthorization: true
      .then (data)->
        q.resolve data
      , (error)->
        q.reject(error)

      q.promise

    updatePassword: (passwordData)->
      passwordData.type = 'updatePassword'
      q = $q.defer()
      $http
        url: API.url + 'auth.php'
        method: 'POST'
        data: passwordData
        skipAuthorization: true
      .then (data)->
        q.resolve data
      , (error)->
        q.reject(error)

      q.promise
  )
]