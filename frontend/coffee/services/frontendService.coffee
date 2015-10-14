angular.module 'frontend.main'
.factory 'fetcherFactory', ['$http', '$q', 'API', ($http, $q, API)->
  return (
    fetchpages: (offset, now)->
      data =
        location: 'fetchPages'
        offset: offset
        now: now
      q = $q.defer()
      $http
        url: API.url + 'frontendHandler.php'
        method: 'POST'
        data: data
      .then (data)->
        q.resolve data
      , (error)->
        q.reject(error)
      q.promise

    fetchPageInfo: (id, now)->
      data =
        location: 'fetchPageInfo'
        id: id
        now: now
      q = $q.defer()
      $http
        url: API.url + 'frontendHandler.php'
        method: 'POST'
        data: data
      .then (data)->
        q.resolve data
      , (error)->
        q.reject(error)
      q.promise

  )

]
.factory 'CommentFactory', ['$http', '$q', 'API', ($http, $q, API)->
  return(
    postComment: (data)->
      data.location = 'postComment'
      q = $q.defer()
      $http
        url: API.url + 'frontendHandler.php'
        method: 'POST'
        data: data
      .then (data)->
        q.resolve data
      , (error)->
        q.reject(error)
      q.promise

    loadMoreComments: (id, offset)->
      data =
        location: 'loadMoreComments'
        id: id
        offset: offset
      q = $q.defer()
      $http
        url: API.url + 'frontendHandler.php'
        method: 'POST'
        data: data
      .then (data)->
        q.resolve data
      , (error)->
        q.reject(error)
      q.promise
  )
]