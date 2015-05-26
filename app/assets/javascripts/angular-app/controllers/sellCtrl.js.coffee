angular.module('app.sellApp').controller("SellCtrl", [
  '$scope',
  ($scope)->
    console.log 'sellCtrl running'

    $scope.sellValue = "Hello angular and rails"

])