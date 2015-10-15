angular.module 'adminPanel', ['ui.router', 'angular-jwt', 'angular-storage', 'adminPanel.authentication', 'angular-md5',
                              'adminPanel.dashBoardCtrl', 'dashBoard.pagesCtrl', 'ngSanitize', 'dashboard.settingsCtrl']
.config ['$stateProvider', '$urlRouterProvider', '$httpProvider', 'jwtInterceptorProvider', '$locationProvider',
  ($stateProvider, $urlRouterProvider, $httpProvider, jwtInterceptorProvider, $locationProvider)->
    $stateProvider
    .state 'auth',
      url: '/auth/:type/:email/:value'
      templateUrl: 'templates/auth.html'
      controller: 'authController'
    .state 'dashboard',
      url: '/dashboard'
      abstract: true
      templateUrl: 'templates/dashboard.html'
      controller: 'dashBoardController'
      data:
        requiresLogin: true
    .state 'dashboard.home',
      url: ''
      templateUrl: 'templates/dashboardHome.html'
      data:
        requiresLogin: true
    .state 'dashboard.pages',
      url: '/manage_pages'
      templateUrl: 'templates/dashboardManagePages.html'
      controller: 'dashBoardPagesController'
      data:
        requiresLogin: true
    .state 'dashboard.createPage',
      url: '/create_page'
      templateUrl: 'templates/dashboardCreatePages.html'
      controller: 'dashBoardCreatePagesController'
      data:
        requiresLogin: true
    .state 'dashboard.editPage',
      url: '/edit_page/:id'
      templateUrl: 'templates/dashboardEditPage.html'
      controller: 'dashBoardEditPagesController'
      data:
        requiresLogin: true
    .state 'dashboard.settings',
      url: '/settings'
      templateUrl: 'templates/dashboardSettings.html'
      controller: 'dashBoardSettingsController'
      data:
        requiresLogin: true
    .state 'dashboard.manageUsers',
      url: '/manage_users'
      templateUrl: 'templates/dashboardManageUsers.html'
      controller: 'dashBoardManageUsersController'
      data:
        requiresLogin: true
    .state 'dashboard.manageMail',
      url: '/manage_mail'
      templateUrl: 'templates/dashboardManageMail.html'
      controller: 'dashBoardManageMailController'
      data:
        requiresLogin: true
    .state 'dashboard.manageComments',
      url: '/manage_comments'
      templateUrl: 'templates/dashboardManageComments.html'
      controller: 'dashBoardManageCommentsController'
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

    $urlRouterProvider.when 'dashboard', 'dashboard.home'
    $urlRouterProvider.otherwise '/auth/login//'

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