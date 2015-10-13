angular.module('dashBoard.pagesCtrl').controller('dashBoardEditPagesController', [
  '$scope', '$stateParams', 'store', 'pageLoaders', function($scope, $stateParams, store, pageLoaders) {
    $scope.$on('$viewContentLoaded', function() {
      $('input#title').characterCounter();
      $scope.parentStatus = true;
      $scope.choseParentFlag = true;
      return $('select').material_select();
    });
    $scope.post = [];
    return $scope.fetchInfo = function() {
      return pageLoaders.fetchForEditing($stateParams.id).then(function(data) {
        console.log(data.data.results);
        return $scope.post = {
          title: data.data.results[0].post_title,
          content: data.data.results[0].post_content,
          is_parent: data.data.results[0].parent_page_id
        };
      }, function(error) {
        return Materialize.toast('Something went wrong', 4000);
      });
    };
  }
]);
