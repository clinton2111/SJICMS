angular.module 'dashBoard.pagesCtrl'
.factory 'mailFactory', ['$http', '$q', 'API', ($http, $q, API)->
  return (
    fetchMail: (offset)->
      data = {
        location: 'fetchMail'
        offset: offset
      }
      q = $q.defer()
      $http
        url: API.url + 'mailHandler.php'
        method: 'POST'
        data: data
      .then (data)->
        q.resolve data
      , (error)->
        q.reject(error)
      q.promise

    deleteMail: (id)->
      data = {
        location: 'deleteMail'
        id: id
      }
      q = $q.defer()
      $http
        url: API.url + 'mailHandler.php'
        method: 'POST'
        data: data
      .then (data)->
        q.resolve data
      , (error)->
        q.reject(error)
      q.promise

    sendMail: (mailData)->
      mailData.location = 'sendMail'
      q = $q.defer()
      $http
        url: API.url + 'mailHandler.php'
        method: 'POST'
        data: mailData
      .then (data)->
        q.resolve data
      , (error)->
        q.reject(error)
      q.promise
  )
]