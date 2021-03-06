angular.module('dashBoard.pagesCtrl').factory('mailFactory', [
  '$http', '$q', 'API', function($http, $q, API) {
    return {
      fetchMail: function(offset) {
        var data, q;
        data = {
          location: 'fetchMail',
          offset: offset
        };
        q = $q.defer();
        $http({
          url: API.url + 'mailHandler.php',
          method: 'POST',
          data: data
        }).then(function(data) {
          return q.resolve(data);
        }, function(error) {
          return q.reject(error);
        });
        return q.promise;
      },
      deleteMail: function(id) {
        var data, q;
        data = {
          location: 'deleteMail',
          id: id
        };
        q = $q.defer();
        $http({
          url: API.url + 'mailHandler.php',
          method: 'POST',
          data: data
        }).then(function(data) {
          return q.resolve(data);
        }, function(error) {
          return q.reject(error);
        });
        return q.promise;
      },
      sendMail: function(mailData) {
        var q;
        mailData.location = 'sendMail';
        q = $q.defer();
        $http({
          url: API.url + 'mailHandler.php',
          method: 'POST',
          data: mailData
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
