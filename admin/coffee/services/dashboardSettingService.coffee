angular.module 'dashboard.settingsCtrl'
.factory 'settingsFactory', ['$http', '$q', 'API', ($http, $q, API)->
  return(
    updatePassword: (password)->
      password.location = 'updatePassword'
      q = $q.defer()
      $http
        url: API.url + 'settingsHandler.php'
        method: 'POST'
        data: password
      .then (data)->
        q.resolve data
      , (error)->
        q.reject(error)
      q.promise
  )
]