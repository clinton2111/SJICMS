angular.module('dashboard.settingsCtrl').factory('settingsFactory', [
  '$http', '$q', 'API', function($http, $q, API) {
    return {
      updatePassword: function(password) {
        var q;
        password.location = 'updatePassword';
        q = $q.defer();
        $http({
          url: API.url + 'settingsHandler.php',
          method: 'POST',
          data: password
        }).then(function(data) {
          return q.resolve(data);
        }, function(error) {
          return q.reject(error);
        });
        return q.promise;
      },
      addUser: function(data) {
        var q;
        data.location = 'addUser';
        q = $q.defer();
        $http({
          url: API.url + 'settingsHandler.php',
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
