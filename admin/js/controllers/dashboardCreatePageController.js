angular.module('dashBoard.pagesCtrl').controller('dashBoardCreatePagesController', [
  '$scope', 'store', function($scope, store) {
    var user;
    $scope.$on('$viewContentLoaded', function() {
      return $('input#title').characterCounter();
    });
    user = store.get('user');
    $scope.publishPage = function() {
      $scope.post.author = user.username;
      $scope.post.publish_date = moment().format("dddd, MMMM Do YYYY, h:mm:ss a");
      $scope.post.is_draft = false;
      return console.log($scope.post);
    };
    $scope.openModal = function(data) {
      if (data === 'schedule') {
        return $('#scheduleModal').openModal();
      } else if (data === 'preview') {
        return $('#previewModal').openModal();
      }
    };
    $scope.saveDraft = function() {
      return console.log($scope.post);
    };
    return $scope.schedulePost = function() {
      return console.log(moment($scope.post.publish_date).format("dddd, MMMM Do YYYY, h:mm:ss a"));
    };
  }
]);
