angular.module('dashBoard.pagesCtrl').controller('dashBoardCreatePagesController', [
  '$scope', 'store', 'publishPages', function($scope, store, publishPages) {
    var user;
    $scope.$on('$viewContentLoaded', function() {
      $('input#title').characterCounter();
      $scope.parentStatus = true;
      $scope.choseParentFlag = true;
      $('select').material_select();
      return $scope.test = true;
    });
    $scope.parentId = 0;
    $scope.pages = [
      {
        id: 1,
        label: 'Page 1'
      }, {
        id: 2,
        label: 'Page 2'
      }, {
        id: 3,
        label: 'Page 3'
      }
    ];
    user = store.get('user');
    $scope.publishPage = function() {
      if ($scope.parentStatus === true) {
        $scope.post.is_parent = 'NULL';
      } else {
        $scope.post.is_parent = $scope.parentId;
      }
      $scope.post.author = user.username;
      $scope.post.publish_date = moment().format("dddd, MMMM Do YYYY, h:mm:ss a");
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
        return $scope.choseParentFlag = false;
      }
    };
  }
]);
