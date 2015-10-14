angular.module('dashBoard.pagesCtrl').controller('dashBoardCreatePagesController', [
  '$scope', 'store', 'publishPages', 'pageLoaders', function($scope, store, publishPages, pageLoaders) {
    var user;
    $scope.$on('$viewContentLoaded', function() {
      $('input#title').characterCounter();
      $scope.parentStatus = true;
      $scope.choseParentFlag = true;
      return $('select').material_select();
    });
    $scope.parentId = 0;
    $scope.pages = [];
    user = store.get('user');
    $scope.publishPage = function() {
      if ($scope.parentStatus === true) {
        $scope.post.is_parent = 'NULL';
      } else {
        $scope.post.is_parent = $scope.parentId.id;
      }
      $scope.post.author = user.username;
      $scope.post.publish_date = moment().format("YYYY-MM-DD h:mm:ss a");
      $scope.post.is_draft = false;
      return publishPages.uploadPage($scope.post).then(function(data) {
        Materialize.toast('Post Published Successfully', '4000');
        return $scope.post = {};
      }, function(error) {
        return Materialize.toast('Something went wrong', 4000);
      });
    };
    $scope.openModal = function(data) {
      if (data === 'schedule') {
        return $('#scheduleModal').openModal();
      } else if (data === 'preview') {
        return $('#previewModal').openModal();
      }
    };
    $scope.saveDraft = function() {
      if ($scope.parentStatus === true) {
        $scope.post.is_parent = 'NULL';
      } else {
        $scope.post.is_parent = $scope.parentId;
      }
      $scope.post.author = user.username;
      $scope.post.publish_date = 'Null';
      $scope.post.is_draft = true;
      return publishPages.uploadPage($scope.post).then(function(data) {
        Materialize.toast('Draft Saved Successfully', '4000');
        return $scope.post = {};
      }, function(error) {
        return Materialize.toast('Something went wrong', 4000);
      });
    };
    $scope.schedulePost = function() {
      if ($scope.parentStatus === true) {
        $scope.post.is_parent = 'NULL';
      } else {
        $scope.post.is_parent = $scope.parentId;
      }
      $scope.post.author = user.username;
      $scope.post.publish_date = moment($scope.post.publish_date).format("dddd, MMMM Do YYYY, h:mm:ss a");
      $scope.post.is_draft = false;
      return publishPages.uploadPage($scope.post).then(function(data) {
        Materialize.toast('Post Scheduled Successfully', '4000');
        $scope.post = {};
        return $('#scheduleModal').closeModal();
      }, function(error) {
        return Materialize.toast('Something went wrong', 4000);
      });
    };
    return $scope.fetchPageList = function() {
      if ($scope.parentStatus === true) {
        return $scope.choseParentFlag = true;
      } else {
        $scope.choseParentFlag = false;
        return pageLoaders.fetchpageNames().then(function(data) {
          return $scope.pages = data.data.results;
        }, function(error) {
          return Materialize.toast('Something went wrong', 4000);
        });
      }
    };
  }
]);
