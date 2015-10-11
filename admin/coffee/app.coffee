angular.module 'adminPanel', ['ui.router', 'angular-jwt', 'angular-storage', 'adminPanel.authentication', 'angular-md5','adminPanel.dashBoardCtrl']
.config ['$stateProvider', '$urlRouterProvider', '$httpProvider', 'jwtInterceptorProvider', '$locationProvider',
  ($stateProvider, $urlRouterProvider, $httpProvider, jwtInterceptorProvider, $locationProvider)->
    $stateProvider
    .state 'auth',
      url: '/auth'
      templateUrl: 'templates/auth.html'
      controller: 'authController'
    .state 'dashboard',
      url: '/dashboard'
#      abstract: true
      templateUrl: 'templates/dashboard.html'
      controller:'dashBoardController'
      data:
        requiresLogin: true

    $urlRouterProvider.otherwise '/auth'
    #    $locationProvider.html5Mode(true)

    jwtInterceptorProvider.tokenGetter = ['config', 'store', (config, store)->
      if config.url.substr(config.url.length - 5) is '.html'
        return null;
      else
        user = store.get 'user'
        if !(_.isNull(user.token)) || !(_.isUndefined(user.token))
          config.headers.Authorization = user.token;
    ]
    $httpProvider.interceptors.push 'jwtInterceptor'

]
.run ['$rootScope', '$state', 'store', 'jwtHelper', '$http', 'API', '$q',
  ($rootScope, $state, store, jwtHelper, $http, API, $q)->
    $rootScope.$on '$stateChangeStart', (e, to)->
      refreshToken = ()->
        q = $q.defer()
        $http.post API.url + 'refreshToken.php', null
        .then (data)->
          q.resolve(data.data)
        , (error)->
          console.log 'Error'
          q.reject(data)
        q.promise

      user = store.get 'user'
      if to.data && to.data.requiresLogin
        if (_.isNull(user) or _.isUndefined(user) or jwtHelper.isTokenExpired(user.token))
          e.preventDefault();
          $state.go 'auth', {type: 'login', email: null, value: null}
        else
          lastUpdate = moment(user.lastUpdate, 'DD-MM-YYYY')
          refreshTokenFlag = moment().isSame(moment(lastUpdate), 'day')

          if !refreshTokenFlag
            refreshToken()
            .then (data)->
              tokenData = data
              if !(_.isNull(tokenData.token) and _.isUndefined(tokenData.token))
                userObj =
                  id: tokenData.id
                  token: tokenData.token
                  username: tokenData.username
                  lastUpdate: moment().format('DD-MM-YYYY')
                store.set 'user', userObj
              else
                e.preventDefault()
                $state.go 'auth', {type: 'login', email: null, value: null}
            , (error)->
              e.preventDefault();

          else
#            console.log 'in Sync'

]
.constant 'API',
  url: '../apis/source/'