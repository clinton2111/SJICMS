angular.module 'frontend.main'
.factory 'fetcherFactory', ['$http', '$q', 'API', ($http, $q, API)->
  return (
    fetchpages: (offset,now)->
      data =
        location: 'fetchPages'
        offset: offset
        now:now
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

    fetchPageInfo: (id,now)->
      data =
        location: 'fetchPageInfo'
        id: id
        now:now
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