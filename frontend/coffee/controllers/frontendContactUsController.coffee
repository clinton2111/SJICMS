angular.module 'frontend.main'
.controller 'frontendContactUsController', ['$scope', 'ContactFactory', ($scope, ContactFactory)->
  $scope.sendEmail = ()->
    $scope.email.now = moment().format("YYYY-MM-DD h:mm:ss a")
    ContactFactory.sendEmail($scope.email)
    .then (data)->
      response = data.data;
      if response.status is 'Success'
        Materialize.toast(response.status + ' - ' + response.message, 4000)
        $scope.email ={}
      else
        Materialize.toast(response.status + ' - ' + response.message, 4000)
    , (error)->
      Materialize.toast('Opps something went wrong.', 4000)
]