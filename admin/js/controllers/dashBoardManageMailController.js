angular.module('dashBoard.pagesCtrl').controller('dashBoardManageMailController', [
  '$scope', 'mailFactory', function($scope, mailFactory) {
    var offset;
    offset = 0;
    $scope.mails = [];
    $scope.fetchMail = function() {
      return mailFactory.fetchMail(offset).then(function(data) {
        var temp;
        if (data.data.status === 'Success') {
          temp = JSON.parse(data.data.results);
          _.each(temp, function(index) {
            return $scope.mails.push(index);
          });
          return Materialize.toast(data.data.message, 4000);
        } else {
          return Materialize.toast(data.data.message, 4000);
        }
      }, function(error) {
        return Materialize.toast('Something went wrong', 4000);
      });
    };
    $scope.loadMoreMail = function() {
      offset = $scope.mails.length;
      return $scope.fetchMail();
    };
    $scope.detailedView = function(index) {
      var mail;
      mail = $scope.mails[index];
      return $scope.detailedMail = {
        index: index,
        sender_name: mail.sender_name,
        sender_email: mail.sender_email,
        sender_subject: mail.sender_subject,
        sender_message: mail.sender_message
      };
    };
    $scope["delete"] = function(index) {
      var id;
      id = $scope.mails[index].id;
      return mailFactory.deleteMail(id).then(function(data) {
        if (data.data.status === 'Success') {
          $scope.mails.splice(index, 1);
          $scope.detailedMail = {};
          return Materialize.toast(data.data.message, 4000);
        } else {
          return Materialize.toast(data.data.message, 4000);
        }
      }, function(error) {
        return Materialize.toast('Something went wrong', 4000);
      });
    };
    $scope.openReplyModal = function() {
      return $('#replyModal').openModal();
    };
    return $scope.sendReply = function() {
      $scope.reply.to_name = $scope.detailedMail.sender_name;
      $scope.reply.to_email = $scope.detailedMail.sender_email;
      $scope.reply.subject = 'RE: ' + $scope.detailedMail.sender_subject;
      $scope.reply.finalmsg = 'Sent message:"<i>' + $scope.detailedMail.sender_message + '</i>" <br><br>' + $scope.reply.msg;
      return mailFactory.sendMail($scope.reply).then(function(data) {
        if (data.data.status === 'Success') {
          $scope.reply = {};
          $('#replyModal').closeModal();
          return Materialize.toast(data.data.message, 4000);
        } else {
          return Materialize.toast(data.data.message, 4000);
        }
      }, function(error) {
        return Materialize.toast('Something went wrong', 4000);
      });
    };
  }
]).filter("myDate", function() {
  return function(input) {
    if (input) {
      return moment(input, 'YYYY-MM-DD h:mm:ss a').format("dddd, MMMM Do YYYY, h:mm a");
    }
  };
});
