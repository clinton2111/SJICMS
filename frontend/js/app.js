angular.module('sjiFrontEnd', ['ui.router', 'frontend.main', 'ngSanitize', 'vcRecaptcha']).config([
  '$stateProvider', '$urlRouterProvider', '$locationProvider', function($stateProvider, $urlRouterProvider, $locationProvider) {
    $locationProvider.html5Mode(true);
    $stateProvider.state('home', {
      url: '/home',
      abstract: true,
      templateUrl: 'frontend/templates/frontendMain.html',
      controller: 'frontendMainController'
    }).state('home.main', {
      url: '',
      templateUrl: 'frontend/templates/frontendHome.html',
      controller: 'frontendHomeController'
    }).state('home.pages', {
      url: '/pages',
      templateUrl: 'frontend/templates/frontendPages.html',
      controller: 'frontendPagesController'
    }).state('home.pageinfo', {
      url: '/page/:id',
      templateUrl: 'frontend/templates/frontendPageInfo.html',
      controller: 'frontendPageInfoController'
    }).state('home.404', {
      url: '/404',
      templateUrl: 'frontend/templates/404.html'
    }).state('home.later', {
      url: '/later',
      templateUrl: 'frontend/templates/later.html'
    }).state('home.contact', {
      url: '/contact_us',
      templateUrl: 'frontend/templates/frontendContactUs.html',
      controller: 'frontendContactUsController'
    }).state('home.searchResults', {
      url: '/search/:query/:results/',
      templateUrl: 'frontend/templates/frontendSearchResults.html',
      controller: 'frontendSearchResultsController'
    });
    $urlRouterProvider.otherwise('/home');
    return $urlRouterProvider.when('home', 'home.main');
  }
]).constant('API', {
  url: '../apis/source/',
  g_reCaptchaKey: '6LfLzA4TAAAAABb_of_QSIS_VGplvbCpnD7cSCt-'
}).run([
  '$rootScope', function($rootScope) {
    return $rootScope.$on("$stateChangeError", console.log.bind(console));
  }
]);
