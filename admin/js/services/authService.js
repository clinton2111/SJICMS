angular.module('adminPanel.authentication').factory('authFactory', [
  '$http', '$q', 'API', function($http, $q, API) {
    return {
      login: function(userCredentials) {
        var q;
        userCredentials.type = 'login';
        q = $q.defer();
        $http({
          url: API.url + 'auth.php',
          method: 'POST',
          data: userCredentials,
          skipAuthorization: true
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
