angular.module 'dashBoard.pagesCtrl', ['ngCkeditor', 'scDateTime']
.controller 'dashBoardPagesController', ['$scope', 'pageLoaders', 'deletePost','$location','$state', ($scope, pageLoaders, deletePost,$location,$state)->
  $scope.$on('$viewContentLoaded', ()->
    $('.tooltipped').tooltip({delay: 50});
  );
  highest = {id: 0}
  $scope.pages = [];
  $scope.loadPages = ()->
    offset = highest.id
    pageLoaders.fetchpages(offset)
    .then (data)->
      response = data.data
      if response.status is 'Success'
        _.each(response.results, (index)->
          $scope.pages.push(index)
        )
        highest = _.max $scope.pages, (page) ->
          page.id
        Materialize.toast('Pages loaded', 4000);
      else if response.status is 'Error'
        Materialize.toast('No more pages', 4000);
    , (error)->
      Materialize.toast('Something went wrong', 4000);

  $scope.deletePost = (id)->
    deletePost.deletepost(id)
    .then (data)->
      response = data.data
      if response.status is 'Success'

        Materialize.toast('Post Deleted.Updating Page..', 4000);
        $location.reload();
      else if response.status is 'Error'
        Materialize.toast('Something went wrong', 4000);
    , (error)->
      Materialize.toast('Something went wrong', 4000);

  $scope.updatePost=(id)->
    $state.go 'dashboard.editPage',{id:id}

  $scope.$watchCollection ['pages'], ()->
    $scope.$apply
  , false
]
.value('scDateTimeConfig', {
    defaultTheme: 'material',
    autosave: true,
    defaultMode: 'date',
    defaultDate: undefined,
    displayMode: 'full',
    defaultOrientation: false,
    displayTwentyfour: false,
    compact: false
  })