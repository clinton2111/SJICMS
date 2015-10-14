angular.module('frontend.main').factory('fetcherFactory', [
  '$http', '$q', 'API', function($http, $q, API) {
    return {
      fetchpages: function(offset, now) {
        var data, q;
        data = {
          location: 'fetchPages',
          offset: offset,
          now: now
        };
        q = $q.defer();
        $http({
          url: API.url + 'frontendHandler.php',
          method: 'POST',
          data: data
        }).then(function(data) {
          return q.resolve(data);
        }, function(error) {
          return q.reject(error);
        });
        return q.promise;
      },
      fetchPageInfo: function(id, now) {
        var data, q;
        data = {
          location: 'fetchPageInfo',
          id: id,
          now: now
        };
        q = $q.defer();
        $http({
          url: API.url + 'frontendHandler.php',
          method: 'POST',
          data: data
        }).then(function(data) {
          return q.resolve(data);
        }, function(error) {
          return q.reject(error);
        });
        return q.promise;
      }
    };
  }
]);
