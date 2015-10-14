angular.module('frontend.main').controller('frontendPageInfoController', [
  '$scope', 'fetcherFactory', '$stateParams', '$state', 'API', 'vcRecaptchaService', 'CommentFactory', function($scope, fetcherFactory, $stateParams, $state, API, vcRecaptchaService, CommentFactory) {
    var offset;
    $scope.$on('$viewContentLoaded', function() {
      return $('.tooltipped').tooltip({
        delay: 50
      });
    });
    $scope.anonymousState = false;
    $scope.publicKey = API.g_reCaptchaKey;
    $scope.showLoader = false;
    offset = 0;
    $scope.fetchPageInfo = function() {
      var id, now;
      now = moment().format("YYYY-MM-DD h:mm:ss a");
      $scope.showLoader = true;
      id = $stateParams.id;
      return fetcherFactory.fetchPageInfo(id, now).then(function(data) {
        var temp_holder;
        if (data.data.status === 'Success') {
          temp_holder = data.data.results;
          $scope.post = {
            author_name: temp_holder[0].author_name,
            post_content: temp_holder[0].post_content,
            post_title: temp_holder[0].post_title,
            publish_date: temp_holder[0].publish_date
          };
          $scope.comments = temp_holder[0].comments;
          return Materialize.toast('Page Loaded', '4000');
        } else if (data.data.status === 'Scheduled') {
          return $state.go('home.later');
        } else if (data.data.status === '404') {
          return $state.go('home.404');
        }
      }, function(error) {
        return Materialize.toast('Something went wrong', 4000);
      })["finally"](function() {
        return $scope.showLoader = false;
      });
    };
    $scope.openModal = function() {
      return $('#commentModal').openModal();
    };
    $scope.postComment = function() {
      if ($scope.anonymousState === true || _.isNull($scope.comment.name) || _.isUndefined($scope.comment.name) || _.isEmpty($scope.comment.name)) {
        $scope.comment.name = 'Anonymous';
      }
      if (vcRecaptchaService.getResponse() === "") {
        Materialize.toast('Please resolve the captcha', 4000);
        return false;
      } else {
        $scope.comment.g_recaptcha_response = vcRecaptchaService.getResponse();
      }
      $scope.comment.now = moment().format("YYYY-MM-DD h:mm:ss a");
      $scope.comment.post_id = $stateParams.id;
      console.log($scope.post);
      return CommentFactory.postComment($scope.comment).then(function(data) {
        var temp;
        if (data.data.status === 'Success') {
          temp = {
            name: $scope.comment.name,
            comment: $scope.comment.comment,
            time_posted: $scope.comment.now
          };
          $scope.comments.push(temp);
          $('#commentModal').closeModal();
          return Materialize.toast(data.data.message, 4000);
        } else if (data.data.status === 'Error') {
          return Materialize.toast(data.data.message, 4000);
        }
      }, function(error) {
        return Materialize.toast('Something went wrong', 4000);
      })["finally"](function() {});
    };
    return $scope.loadMoreComments = function() {
      offset = $scope.comments.length;
      return CommentFactory.loadMoreComments($stateParams.id, offset).then(function(data) {
        var temp;
        if (data.data.status === 'Success') {
          temp = data.data.results;
          _.each(temp, function(index) {
            return $scope.comments.push(index);
          });
          return Materialize.toast(data.data.message, 4000);
        } else if (data.data.status === 'Error') {
          return Materialize.toast(data.data.message, 4000);
        }
      }, function(error) {
        return Materialize.toast('Something went wrong', 4000);
      })["finally"](function() {});
    };
  }
]);
