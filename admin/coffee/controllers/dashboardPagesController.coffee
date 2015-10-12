angular.module 'dashBoard.pagesCtrl', ['ngCkeditor', 'scDateTime']
.controller 'dashBoardPagesController', ['$scope', ($scope)->
  $scope.$on('$viewContentLoaded', ()->
    $('.tooltipped').tooltip({delay: 50});
  );
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