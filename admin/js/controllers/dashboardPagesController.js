angular.module('dashBoard.pagesCtrl', ['ngCkeditor', 'scDateTime']).controller('dashBoardPagesController', [
  '$scope', 'pageLoaders', function($scope, pageLoaders) {
    $scope.$on('$viewContentLoaded', function() {
      return $('.tooltipped').tooltip({
        delay: 50
      });
    });
    return $scope.loadPages = function(offset) {
      return pageLoaders.fetchpages(offset).then(function(data) {
        return console.log(data.data);
      }, function(error) {
        return Materialize.toast('Something went wrong', 4000);
      });
    };
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
