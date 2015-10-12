angular.module 'dashBoard.pagesCtrl'
.controller 'dashBoardCreatePagesController', ['$scope', 'store', 'publishPages', ($scope, store, publishPages)->
  $scope.$on('$viewContentLoaded', ()->
    $('input#title').characterCounter();
    $scope.parentStatus = true
    $scope.choseParentFlag = true
    $('select').material_select();

    $scope.test=true
  );
  $scope.parentId = 0
  $scope.pages = [{
    id: 1
    label: 'Page 1'
  }, {
    id: 2
    label: 'Page 2'
  }, {
    id: 3
    label: 'Page 3'
  }
  ]
  user = store.get 'user'
  $scope.publishPage = ()->
#    Todo:Fix Selection of parent page
    if $scope.parentStatus is true
      $scope.post.is_parent = 'NULL'
    else
      $scope.post.is_parent = $scope.parentId

    $scope.post.author = user.username
    $scope.post.publish_date = moment().format("dddd, MMMM Do YYYY, h:mm:ss a")
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


]
