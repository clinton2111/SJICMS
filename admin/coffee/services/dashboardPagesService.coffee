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

  )
]