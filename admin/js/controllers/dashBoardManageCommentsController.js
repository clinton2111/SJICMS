angular.module('dashBoard.pagesCtrl').controller('dashBoardManageCommentsController', [
  '$scope', 'pageLoaders', 'commentFactory', function($scope, pageLoaders, commentFactory) {
    var offset;
    offset = 0;
    $scope.comments = [];
    $scope.fetchPageList = function() {
      return pageLoaders.fetchpageNames().then(function(data) {
        return $scope.pages = data.data.results;
      }, function(error) {
        return Materialize.toast('Something went wrong', 4000);
      });
    };
    $scope.fetchComments = function(offset) {
      if (offset === 0) {
        $scope.comments = [];
      }
      if (_.isUndefined($scope.pageTitle) || _.isNull($scope.pageTitle) || _.isEmpty($scope.pageTitle)) {
        Materialize.toast('Please choose a post', 4000);
        return false;
      }
      return commentFactory.fetchComments(offset, $scope.pageTitle.id).then(function(data) {
        var temp;
        if (data.data.status === "Success") {
          temp = JSON.parse(data.data.results);
          return _.each(temp, function(index) {
            return $scope.comments.push(index);
          });
        } else {
          return Materialize.toast(data.data.message, 4000);
        }
      }, function(error) {
        return Materialize.toast('Something went wrong', 4000);
      });
    };
    $scope.loadMore = function() {
      offset = $scope.comments.length;
      return $scope.fetchComments(offset);
    };
    return $scope.deleteComment = function(index) {
      var id;
      id = $scope.comments[index].id;
      return commentFactory.deleteComment(id).then(function(data) {
        if (data.data.status === 'Success') {
          $scope.comments.splice(index, 1);
          return Materialize.toast(data.data.message, 4000);
        } else {
          return Materialize.toast(data.data.message, 4000);
        }
      }, function(error) {
        return Materialize.toast('Something went wrong', 4000);
      });
    };
  }
]);
