angular.module('dashBoard.pagesCtrl', ['ngCkeditor', 'scDateTime']).controller('dashBoardPagesController', [
  '$scope', function($scope) {
    return $scope.$on('$viewContentLoaded', function() {
      return $('.tooltipped').tooltip({
        delay: 50
      });
    });
  }
]).value('scDateTimeConfig', {
  defaultTheme: 'material',
  autosave: true,
  defaultMode: 'date',
  defaultDate: void 0,
  displayMode: 'full',
  defaultOrientation: false,
  displayTwentyfour: false,
  compact: false
});
