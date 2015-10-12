angular.module 'dashBoard.pagesCtrl'
.controller 'dashBoardCreatePagesController', ['$scope', 'store', ($scope, store)->
  $scope.$on('$viewContentLoaded', ()->
    $('input#title').characterCounter();
  );

  #  $scope.editorOptions = {
  #
  #  };
  user = store.get 'user'
  $scope.publishPage = ()->
    $scope.post.author = user.username
    $scope.post.publish_date = moment().format("dddd, MMMM Do YYYY, h:mm:ss a")
    $scope.post.is_draft = false
    console.log $scope.post

  $scope.openModal = (data)->
    if data == 'schedule'
      $ '#scheduleModal'
      .openModal();
    else if data == 'preview'
      $ '#previewModal'
      .openModal();
  $scope.saveDraft = ()->
    console.log $scope.post

  $scope.schedulePost = ()->
    console.log moment($scope.post.publish_date).format("dddd, MMMM Do YYYY, h:mm:ss a")
]
