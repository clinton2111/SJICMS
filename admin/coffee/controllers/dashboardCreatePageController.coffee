angular.module 'dashBoard.pagesCtrl'
.controller 'dashBoardCreatePagesController', ['$scope', 'store', 'publishPages', 'pageLoaders',
  ($scope, store, publishPages, pageLoaders)->
    $scope.$on('$viewContentLoaded', ()->
      $('input#title').characterCounter();
      $scope.parentStatus = true
      $scope.choseParentFlag = true
      $('select').material_select();
    );
    $scope.parentId = 0
    $scope.pages = []
    user = store.get 'user'
    $scope.publishPage = ()->
      if $scope.parentStatus is true
        $scope.post.is_parent = 'NULL'
      else
        $scope.post.is_parent = $scope.parentId.id

      $scope.post.author = user.username
      $scope.post.publish_date = moment().format("YYYY-MM-DD h:mm:ss a")
      $scope.post.is_draft = false
      publishPages.uploadPage($scope.post)
      .then (data)->
        Materialize.toast 'Post Published Successfully', '4000'
        $scope.post = {}
      , (error)->
        Materialize.toast('Something went wrong', 4000);


    $scope.openModal = (data)->
      if data == 'schedule'
        $ '#scheduleModal'
        .openModal();
      else if data == 'preview'
        $ '#previewModal'
        .openModal();

    $scope.saveDraft = ()->
      if $scope.parentStatus is true
        $scope.post.is_parent = 'NULL'
      else
        $scope.post.is_parent = $scope.parentId

      $scope.post.author = user.username
      $scope.post.publish_date = 'Null'
      $scope.post.is_draft = true

      publishPages.uploadPage($scope.post)
      .then (data)->
        Materialize.toast 'Draft Saved Successfully', '4000'
        $scope.post = {}
      , (error)->
        Materialize.toast('Something went wrong', 4000);

    $scope.schedulePost = ()->
      if $scope.parentStatus is true
        $scope.post.is_parent = 'NULL'
      else
        $scope.post.is_parent = $scope.parentId

      $scope.post.author = user.username
      $scope.post.publish_date = moment($scope.post.publish_date).format("dddd, MMMM Do YYYY, h:mm:ss a")
      $scope.post.is_draft = false

      publishPages.uploadPage($scope.post)
      .then (data)->
        Materialize.toast 'Post Scheduled Successfully', '4000'
        $scope.post = {}
        $ '#scheduleModal'
        .closeModal()
      , (error)->
        Materialize.toast('Something went wrong', 4000);

    $scope.fetchPageList = ()->
      if $scope.parentStatus is true
#      make page as parent
        $scope.choseParentFlag = true

      else
        $scope.choseParentFlag = false
        pageLoaders.fetchpageNames()
        .then (data)->
          $scope.pages = data.data.results

        , (error)->
          Materialize.toast('Something went wrong', 4000);


]
