angular.module('dashBoard.pagesCtrl', ['ngCkeditor', 'scDateTime']).controller('dashBoardPagesController', [
  '$scope', 'pageLoaders', 'deletePost', '$location', '$state', function($scope, pageLoaders, deletePost, $location, $state) {
    var offset;
    $scope.$on('$viewContentLoaded', function() {
      return $('.tooltipped').tooltip({
        delay: 50
      });
    });
    offset = 0;
    $scope.pages = [];
    $scope.loadPages = function() {
      offset;
      return pageLoaders.fetchpages(offset).then(function(data) {
        var response;
        response = data.data;
        if (response.status === 'Success') {
          _.each(response.results, function(index) {
            return $scope.pages.push(index);
          });
          offset = $scope.pages.length;
          return Materialize.toast('Pages loaded', 4000);
        } else if (response.status === 'Error') {
          return Materialize.toast('No more pages', 4000);
        }
      }, function(error) {
        return Materialize.toast('Something went wrong', 4000);
      });
    };
    $scope.deletePost = function(id) {
      return deletePost.deletepost(id).then(function(data) {
        var response;
        response = data.data;
        if (response.status === 'Success') {
          Materialize.toast('Post Deleted.Updating Page..', 4000);
          return $location.reload();
        } else if (response.status === 'Error') {
          return Materialize.toast('Something went wrong', 4000);
        }
      }, function(error) {
        return Materialize.toast('Something went wrong', 4000);
      });
    };
    $scope.updatePost = function(id) {
      return $state.go('dashboard.editPage', {
        id: id
      });
    };
    return $scope.$watchCollection(['pages'], function() {
      return $scope.$apply;
    }, false);
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
