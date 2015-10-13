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
      },
      recoverPassword: function(emailData) {
        var q;
        emailData.type = 'recoverPassword';
        q = $q.defer();
        $http({
          url: API.url + 'auth.php',
          method: 'POST',
          data: emailData,
          skipAuthorization: true
        }).then(function(data) {
          return q.resolve(data);
        }, function(error) {
          return q.reject(error);
        });
        return q.promise;
      },
      updatePassword: function(passwordData) {
        var q;
        passwordData.type = 'updatePassword';
        q = $q.defer();
        $http({
          url: API.url + 'auth.php',
          method: 'POST',
          data: passwordData,
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
