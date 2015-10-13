angular.module 'dashBoard.pagesCtrl'
.controller 'dashBoardEditPagesController', ['$scope', '$stateParams', 'store', 'pageLoaders',
  ($scope, $stateParams, store, pageLoaders)->
    $scope.$on('$viewContentLoaded', ()->
      $('input#title').characterCounter();
      $scope.parentStatus = true
      $scope.choseParentFlag = true
      $('select').material_select();
    );
    $scope.post = []
    $scope.fetchInfo = ()->
      pageLoaders.fetchForEditing($stateParams.id)
      .then (data)->
        console.log data.data.results
        $scope.post = {
          title: data.data.results[0].post_title
          content: data.data.results[0].post_content
          is_parent: data.data.results[0].parent_page_id
        }
      , (error)->
        Materialize.toast('Something went wrong', 4000);


]