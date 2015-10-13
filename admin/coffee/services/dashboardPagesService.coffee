angular.module 'dashBoard.pagesCtrl'
.factory 'publishPages', ['$http', '$q', 'API', ($http, $q, API)->
  return (
    uploadPage: (pageData)->
      pageData.location = 'savePage'
      q = $q.defer()
      $http
        url: API.url + 'pagesHandler.php'
        method: 'POST'
        data: pageData
      .then (data)->
        q.resolve data
      , (error)->
        q.reject(error)
      q.promise

    updatePage: (pageData)->
      pageData.location = 'updatePage'
      q = $q.defer()
      $http
        url: API.url + 'pagesHandler.php'
        method: 'POST'
        data: pageData
      .then (data)->
        q.resolve data
      , (error)->
        q.reject(error)
      q.promise
  )
]
.factory 'pageLoaders', ['$http', '$q', 'API', ($http, $q, API)->
  return (
    fetchpages: (offset)->
      q = $q.defer()
      $http
        url: API.url + 'pagesHandler.php'
        method: 'POST'
        data:
          offset: offset
          location: 'fetchPagesInfo'
      .then (data)->
        q.resolve data
      , (error)->
        q.reject(error)
      q.promise

    fetchpageNames: ->
      q = $q.defer()
      $http
        url: API.url + 'pagesHandler.php'
        method: 'POST'
        data:
          location: 'fetchPagesNames'
      .then (data)->
        q.resolve data
      , (error)->
        q.reject(error)
      q.promise

    fetchForEditing: (id)->
      q = $q.defer()
      $http
        url: API.url + 'pagesHandler.php'
        method: 'POST'
        data:
          id: id
          location: 'fetchPagesForEditing'
      .then (data)->
        q.resolve data
      , (error)->
        q.reject(error)
      q.promise


  )
]
.factory 'deletePost', ['$http', '$q', 'API', ($http, $q, API)->
  return (
    deletepost: (id)->
      q = $q.defer()
      $http
        url: API.url + 'pagesHandler.php'
        method: 'POST'
        data:
          id: id
          location: 'deletePost'
      .then (data)->
        q.resolve data
      , (error)->
        q.reject(error)
      q.promise

  )
]