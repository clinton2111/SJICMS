angular.module('sjiFrontEnd', ['ui.router', 'frontend.main']).config([
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
    });
    $urlRouterProvider.otherwise('/home');
    return $urlRouterProvider.when('home', 'home.main');
  }
]).constant('API', {
  url: '../apis/source/'
}).run([
  '$rootScope', function($rootScope) {
    return $rootScope.$on("$stateChangeError", console.log.bind(console));
  }
]);
