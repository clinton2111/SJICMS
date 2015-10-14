angular.module 'dashBoard.pagesCtrl'
.controller 'dashBoardEditPagesController', ['$scope', '$stateParams', 'store', 'pageLoaders','publishPages'
  ($scope, $stateParams, store, pageLoaders,publishPages)->
    $scope.$on('$viewContentLoaded', ()->
      $('input#title').characterCounter();
    );
    $scope.post = []
    $scope.fetchInfo = ()->
      pageLoaders.fetchForEditing($stateParams.id)
      .then (data)->
        console.log data.data.results
        $scope.post = {
          id: data.data.results[0].id
          title: data.data.results[0].post_title
          content: data.data.results[0].post_content
          is_parent: data.data.results[0].parent_page_id
        }
      , (error)->
        Materialize.toast('Something went wrong', 4000);

    $scope.openModal = (data)->
      console.log(data)
      if data == 'schedule'
        $ '#scheduleModal'
        .openModal();
      else if data == 'preview'
        $ '#previewModal'
        .openModal();

    user = store.get 'user'
    $scope.publishPage = ()->
      $scope.post.author = user.username
      $scope.post.publish_date = moment().format("YYYY-MM-DD h:mm:ss a")
      $scope.post.is_draft = false
      publishPages.updatePage($scope.post)
      .then (data)->
        console.log data
        if data.data.status is 'Success' then Materialize.toast 'Post Updated Successfully', '4000'
        else if data.data.status is 'Error' then Materialize.toast data.data.message, '4000'
      , (error)->
        Materialize.toast('Something went wrong', 4000);


]