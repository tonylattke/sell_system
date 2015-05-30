sellApp.factory('Client', ['$resource', function($resource) {
  function Client() {
    this.service = $resource('/api/clients/:id', {clientId: '@id'});
  };
  Client.prototype.all = function() {
    return this.service.query();
  };
  return new Client;
}]);