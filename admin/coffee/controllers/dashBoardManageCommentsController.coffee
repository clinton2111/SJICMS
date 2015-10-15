angular.module 'dashBoard.pagesCtrl'
.controller 'dashBoardManageCommentsController', ['$scope', 'pageLoaders', 'commentFactory',
  ($scope, pageLoaders, commentFactory)->
    offset = 0;
    $scope.comments = []
    $scope.fetchPageList = ()->
      pageLoaders.fetchpageNames()
      .then (data)->
        $scope.pages = data.data.results

      , (error)->
        Materialize.toast('Something went wrong', 4000);

    $scope.fetchComments = (offset) ->
      if offset is 0 then $scope.comments = []
      if _.isUndefined($scope.pageTitle) or _.isNull($scope.pageTitle) or _.isEmpty($scope.pageTitle)
        Materialize.toast('Please choose a post', 4000);
        return false
      commentFactory.fetchComments(offset, $scope.pageTitle.id)
      .then (data)->
        if data.data.status is "Success"
          temp = JSON.parse(data.data.results);
          _.each temp, (index)->
            $scope.comments.push(index)
        else
          Materialize.toast(data.data.message, 4000);
      , (error)->
        Materialize.toast('Something went wrong', 4000);

    $scope.loadMore = ->
      offset = $scope.comments.length
      $scope.fetchComments(offset)

    $scope.deleteComment = (index)->
      id = $scope.comments[index].id;
      commentFactory.deleteComment(id)
      .then (data)->
        if data.data.status is 'Success'
          $scope.comments.splice(index, 1);
          Materialize.toast(data.data.message, 4000);
        else
          Materialize.toast(data.data.message, 4000);

      , (error)->
        Materialize.toast('Something went wrong', 4000);


]
