angular.module 'frontend.main'
.controller 'frontendPageInfoController', ['$scope', 'fetcherFactory', '$stateParams', '$state', 'API',
                                           'vcRecaptchaService', 'CommentFactory',
  ($scope, fetcherFactory, $stateParams, $state, API, vcRecaptchaService, CommentFactory)->
    $scope.$on('$viewContentLoaded', ()->
      $('.tooltipped').tooltip({delay: 50});
    );
    $scope.anonymousState = false
    $scope.publicKey = API.g_reCaptchaKey
    $scope.showLoader = false;
    offset = 0;
    $scope.fetchPageInfo = ->
      now = moment().format("YYYY-MM-DD h:mm:ss a")
      $scope.showLoader = true;
      id = $stateParams.id
      fetcherFactory.fetchPageInfo(id, now)
      .then (data)->
        if data.data.status is 'Success'
          temp_holder = data.data.results
          $scope.post = {
            author_name: temp_holder[0].author_name
            post_content: temp_holder[0].post_content
            post_title: temp_holder[0].post_title
            publish_date: temp_holder[0].publish_date
          }
          $scope.comments = temp_holder[0].comments
          Materialize.toast 'Page Loaded', '4000'
        else if data.data.status is 'Scheduled'
          $state.go 'home.later'
        else if data.data.status is '404'
          $state.go 'home.404'
      , (error)->
        Materialize.toast('Something went wrong', 4000);
      .finally ()->
        $scope.showLoader = false;

    $scope.openModal = ()->
      $('#commentModal').openModal();

    $scope.postComment = ()->
      if $scope.anonymousState is true or _.isNull($scope.comment.name) or _.isUndefined($scope.comment.name) or _.isEmpty($scope.comment.name)
        $scope.comment.name = 'Anonymous'
      if vcRecaptchaService.getResponse() is ""
        Materialize.toast('Please resolve the captcha', 4000);
        return false
      else $scope.comment.g_recaptcha_response = vcRecaptchaService.getResponse()
      $scope.comment.now = moment().format("YYYY-MM-DD h:mm:ss a")
      $scope.comment.post_id = $stateParams.id
      console.log $scope.post

      CommentFactory.postComment($scope.comment)
      .then (data)->
        if data.data.status is 'Success'
          temp = {
            name: $scope.comment.name
            comment: $scope.comment.comment
            time_posted: $scope.comment.now
          }
          $scope.comments.push temp
          $('#commentModal').closeModal();
          Materialize.toast(data.data.message, 4000);
        else if data.data.status is 'Error'
          Materialize.toast(data.data.message, 4000);
      , (error)->
        Materialize.toast('Something went wrong', 4000);
      .finally ()->

    $scope.loadMoreComments = ->
      offset = $scope.comments.length
      CommentFactory.loadMoreComments($stateParams.id, offset)
      .then (data)->
        if data.data.status is 'Success'
          temp = (data.data.results)
          _.each temp, (index)->
            $scope.comments.push index

          Materialize.toast(data.data.message, 4000);
        else if data.data.status is 'Error'
          Materialize.toast(data.data.message, 4000);
      , (error)->
        Materialize.toast('Something went wrong', 4000);
      .finally ()->


]