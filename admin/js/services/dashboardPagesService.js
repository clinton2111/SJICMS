angular.module('dashBoard.pagesCtrl').factory('publishPages', [
  '$http', '$q', 'API', function($http, $q, API) {
    return {
      uploadPage: function(pageData) {
        var q;
        pageData.location = 'savePage';
        q = $q.defer();
        $http({
          url: API.url + 'pagesHandler.php',
          method: 'POST',
          data: pageData
        }).then(function(data) {
          return q.resolve(data);
        }, function(error) {
          return q.reject(error);
        });
        return q.promise;
      }
    };
  }
]).factory('pageLoaders', [
  '$http', '$q', 'API', function($http, $q, API) {
    return {
      fetchpages: function(offset) {
        var q;
        q = $q.defer();
        $http({
          url: API.url + 'pagesHandler.php',
          method: 'POST',
          data: {
            offset: offset,
            location: 'fetchPagesInfo'
          }
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
