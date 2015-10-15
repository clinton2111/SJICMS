angular.module('dashBoard.pagesCtrl').controller('dashBoardEditPagesController', [
    '$scope', '$stateParams', 'store', 'pageLoaders', 'publishPages', function ($scope, $stateParams, store, pageLoaders, publishPages) {
        var user;
        $scope.$on('$viewContentLoaded', function () {
            return $('input#title').characterCounter();
        });
        $scope.post = [];
        $scope.fetchInfo = function () {
            return pageLoaders.fetchForEditing($stateParams.id).then(function (data) {
                console.log(data.data.results);
                return $scope.post = {
                    id: data.data.results[0].id,
                    title: data.data.results[0].post_title,
                    content: data.data.results[0].post_content,
                    is_parent: data.data.results[0].parent_page_id
                };
            }, function (error) {
                return Materialize.toast('Something went wrong', 4000);
            });
        };
        $scope.openModal = function (data) {
            console.log(data);
            if (data === 'schedule') {
                return $('#scheduleModal').openModal();
            } else if (data === 'preview') {
                return $('#previewModal').openModal();
            }
        };
        user = store.get('user');
        return $scope.publishPage = function () {
            $scope.post.author = user.username;
            $scope.post.publish_date = moment().format("YYYY-MM-DD h:mm:ss a");
            $scope.post.is_draft = false;
            return publishPages.updatePage($scope.post).then(function (data) {
                console.log(data);
                if (data.data.status === 'Success') {
                    return Materialize.toast('Post Updated Successfully', '4000');
                } else if (data.data.status === 'Error') {
                    return Materialize.toast(data.data.message, '4000');
                }
            }, function (error) {
                return Materialize.toast('Something went wrong', 4000);
            });
        };
    }
]);
