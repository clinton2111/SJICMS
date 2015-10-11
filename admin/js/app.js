angular.module('adminPanel', ['ui.router', 'angular-jwt', 'angular-storage', 'adminPanel.authentication', 'angular-md5', 'adminPanel.dashBoardCtrl', 'dashBoard.pagesCtrl']).config([
  '$stateProvider', '$urlRouterProvider', '$httpProvider', 'jwtInterceptorProvider', '$locationProvider', function($stateProvider, $urlRouterProvider, $httpProvider, jwtInterceptorProvider, $locationProvider) {
    $stateProvider.state('auth', {
      url: '/auth',
      templateUrl: 'templates/auth.html',
      controller: 'authController'
    }).state('dashboard', {
      url: '/dashboard',
      abstract: true,
      templateUrl: 'templates/dashboard.html',
      controller: 'dashBoardController',
      data: {
        requiresLogin: true
      }
    }).state('dashboard.home', {
      url: '',
      templateUrl: 'templates/dashboardHome.html',
      data: {
        requiresLogin: true
      }
    }).state('dashboard.pages', {
      url: '',
      templateUrl: 'templates/dashboardManagePages.html',
      controller: 'dashBoardPagesController',
      data: {
        requiresLogin: true
      }
    });
    $urlRouterProvider.otherwise('/auth');
    jwtInterceptorProvider.tokenGetter = [
      'config', 'store', function(config, store) {
        var user;
        if (config.url.substr(config.url.length - 5) === '.html') {
          return null;
        } else {
          user = store.get('user');
          if (!(_.isNull(user.token)) || !(_.isUndefined(user.token))) {
            return config.headers.Authorization = user.token;
          }
        }
      }
    ];
    $httpProvider.interceptors.push('jwtInterceptor');
    $urlRouterProvider.when('dashboard', 'dashboard.home');
    return $urlRouterProvider.otherwise('/auth');
  }
]).run([
  '$rootScope', '$state', 'store', 'jwtHelper', '$http', 'API', '$q', function($rootScope, $state, store, jwtHelper, $http, API, $q) {
    return $rootScope.$on('$stateChangeStart', function(e, to) {
      var lastUpdate, refreshToken, refreshTokenFlag, user;
      refreshToken = function() {
        var q;
        q = $q.defer();
        $http.post(API.url + 'refreshToken.php', null).then(function(data) {
          return q.resolve(data.data);
        }, function(error) {
          console.log('Error');
          return q.reject(data);
        });
        return q.promise;
      };
      user = store.get('user');
      if (to.data && to.data.requiresLogin) {
        if (_.isNull(user) || _.isUndefined(user) || jwtHelper.isTokenExpired(user.token)) {
          e.preventDefault();
          return $state.go('auth', {
            type: 'login',
            email: null,
            value: null
          });
        } else {
          lastUpdate = moment(user.lastUpdate, 'DD-MM-YYYY');
          refreshTokenFlag = moment().isSame(moment(lastUpdate), 'day');
          if (!refreshTokenFlag) {
            return refreshToken().then(function(data) {
              var tokenData, userObj;
              tokenData = data;
              if (!(_.isNull(tokenData.token) && _.isUndefined(tokenData.token))) {
                userObj = {
                  id: tokenData.id,
                  token: tokenData.token,
                  username: tokenData.username,
                  lastUpdate: moment().format('DD-MM-YYYY')
                };
                return store.set('user', userObj);
              } else {
                e.preventDefault();
                return $state.go('auth', {
                  type: 'login',
                  email: null,
                  value: null
                });
              }
            }, function(error) {
              return e.preventDefault();
            });
          } else {

          }
        }
      }
    });
  }
]).constant('API', {
  url: '../apis/source/'
});
