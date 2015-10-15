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

    addUser: (data)->
      data.location = 'addUser'
      q = $q.defer()
      $http
        url: API.url + 'settingsHandler.php'
        method: 'POST'
        data: data
      .then (data)->
        q.resolve data
      , (error)->
        q.reject(error)
      q.promise

    fetchAdminDetails:() ->
      data =
        location: 'fetchAdminDetails'
      q = $q.defer()
      $http
        url: API.url + 'settingsHandler.php'
        method: 'POST'
        data: data
      .then (data)->
        q.resolve data
      , (error)->
        q.reject(error)
      q.promise

    deletePerson: (data)->
      data.location = 'deletePerson'
      q = $q.defer()
      $http
        url: API.url + 'settingsHandler.php'
        method: 'POST'
        data: data
      .then (data)->
        q.resolve data
      , (error)->
        q.reject(error)
      q.promise

  )
]