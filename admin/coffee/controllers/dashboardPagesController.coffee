angular.module 'dashBoard.pagesCtrl', ['ngCkeditor', 'scDateTime']
.controller 'dashBoardPagesController', ['$scope', 'pageLoaders', ($scope, pageLoaders)->
  $scope.$on('$viewContentLoaded', ()->
    $('.tooltipped').tooltip({delay: 50});
  );

  $scope.loadPages = (offset)->
    pageLoaders.fetchpages(offset)
    .then (data)->
      console.log data.data
    , (error)->
      Materialize.toast('Something went wrong', 4000);


]
.value('scDateTimeConfig', {
    defaultTheme: 'material',
    autosave: true,
    defaultMode: 'date',
    defaultDate: undefined,
    displayMode: 'full',
    defaultOrientation: false,
    displayTwentyfour: false,
    compact: false
  })