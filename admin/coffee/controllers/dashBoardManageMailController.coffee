angular.module 'dashBoard.pagesCtrl'
.controller 'dashBoardManageMailController', ['$scope', 'mailFactory', ($scope, mailFactory)->
  offset = 0;
  $scope.mails = []
  $scope.fetchMail = ->
    mailFactory.fetchMail(offset)
    .then (data)->
      if data.data.status is 'Success'
        temp = (JSON.parse(data.data.results));
        _.each temp, (index)->
          $scope.mails.push(index)
        Materialize.toast(data.data.message, 4000);
      else
        Materialize.toast(data.data.message, 4000);

    , (error)->
      Materialize.toast('Something went wrong', 4000);

  $scope.loadMoreMail = ->
    offset = $scope.mails.length
    $scope.fetchMail()

  $scope.detailedView = (index)->
    mail = $scope.mails[index]
    $scope.detailedMail =
      index: index
      sender_name: mail.sender_name
      sender_email: mail.sender_email
      sender_subject: mail.sender_subject
      sender_message: mail.sender_message

  $scope.delete = (index)->
    id = $scope.mails[index].id;
    mailFactory.deleteMail(id)
    .then (data)->
      if data.data.status is 'Success'
        $scope.mails.splice(index, 1);
        $scope.detailedMail = {}
        Materialize.toast(data.data.message, 4000);
      else
        Materialize.toast(data.data.message, 4000);

    , (error)->
      Materialize.toast('Something went wrong', 4000);

  $scope.openReplyModal = ->
    $('#replyModal').openModal();
  $scope.sendReply = ->
    $scope.reply.to_name = $scope.detailedMail.sender_name
    $scope.reply.to_email = $scope.detailedMail.sender_email
    $scope.reply.subject = 'RE: ' + $scope.detailedMail.sender_subject
    $scope.reply.finalmsg = 'Sent message:"<i>' + $scope.detailedMail.sender_message + '</i>" <br><br>' + $scope.reply.msg

    mailFactory.sendMail($scope.reply)
    .then (data)->
      if data.data.status is 'Success'
        $scope.reply = {}
        $('#replyModal').closeModal();
        Materialize.toast(data.data.message, 4000);
      else
        Materialize.toast(data.data.message, 4000);

    , (error)->
      Materialize.toast('Something went wrong', 4000);

]
.filter "myDate", ()->
  (input)->
    if input then moment(input, 'YYYY-MM-DD h:mm:ss a').format("dddd, MMMM Do YYYY, h:mm a")