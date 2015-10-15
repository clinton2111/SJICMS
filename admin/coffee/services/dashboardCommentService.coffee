angular.module 'dashBoard.pagesCtrl'
.factory 'commentFactory', ['$http', '$q', 'API', ($http, $q, API)->
  return (
    fetchComments: (offset, id)->
      data = {
        location: 'fetchComments'
        offset: offset
        id: id
      }
      q = $q.defer()
      $http
        url: API.url + 'commentHandler.php'
        method: 'POST'
        data: data
      .then (data)->
        q.resolve data
      , (error)->
        q.reject(error)
      q.promise

    deleteComment: (id)->
      data = {
        location: 'deleteComment'
        id: id
      }
      q = $q.defer()
      $http
        url: API.url + 'commentHandler.php'
        method: 'POST'
        data: data
      .then (data)->
        q.resolve data
      , (error)->
        q.reject(error)
      q.promise
  )
]