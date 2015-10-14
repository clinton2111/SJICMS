angular.module 'sjiFrontEnd', ['ui.router', 'frontend.main','ngSanitize','reCAPTCHA']
.config ['$stateProvider', '$urlRouterProvider', '$locationProvider',
  ($stateProvider, $urlRouterProvider, $locationProvider)->
    $locationProvider.html5Mode(true)
    $stateProvider.state 'home',
      url: '/home'
      abstract: true
      templateUrl: 'frontend/templates/frontendMain.html'
      controller: 'frontendMainController'
    .state 'home.main',
      url: ''
      templateUrl: 'frontend/templates/frontendHome.html'
      controller: 'frontendHomeController'
    .state 'home.pages',
      url: '/pages'
      templateUrl: 'frontend/templates/frontendPages.html'
      controller: 'frontendPagesController'
    .state 'home.pageinfo',
      url: '/page/:id'
      templateUrl: 'frontend/templates/frontendPageInfo.html'
      controller: 'frontendPageInfoController'
    .state 'home.404',
      url: '/404'
      templateUrl: 'frontend/templates/404.html'
    .state 'home.later',
      url: '/later'
      templateUrl: 'frontend/templates/later.html'


    $urlRouterProvider.otherwise '/home'
    $urlRouterProvider.when 'home', 'home.main'


]
.constant 'API',
  url: '../apis/source/'


.run ['$rootScope',
  ($rootScope)->
    $rootScope.$on("$stateChangeError", console.log.bind(console))
]