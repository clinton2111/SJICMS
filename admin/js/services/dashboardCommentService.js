angular.module('dashBoard.pagesCtrl').factory('commentFactory', [
  '$http', '$q', 'API', function($http, $q, API) {
    return {
      fetchComments: function(offset, id) {
        var data, q;
        data = {
          location: 'fetchComments',
          offset: offset,
          id: id
        };
        q = $q.defer();
        $http({
          url: API.url + 'commentHandler.php',
          method: 'POST',
          data: data
        }).then(function(data) {
          return q.resolve(data);
        }, function(error) {
          return q.reject(error);
        });
        return q.promise;
      },
      deleteComment: function(id) {
        var data, q;
        data = {
          location: 'deleteComment',
          id: id
        };
        q = $q.defer();
        $http({
          url: API.url + 'commentHandler.php',
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
