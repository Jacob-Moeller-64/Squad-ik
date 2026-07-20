(function () {
  'use strict';

  angular.module('fieldserve', ['ngRoute']).config(['$routeProvider', function ($routeProvider) {
    $routeProvider
      .when('/orders', {
        templateUrl: 'Scripts/app/templates/order-list.html',
        controller: 'OrderListController'
      })
      .when('/orders/:id', {
        templateUrl: 'Scripts/app/templates/order-detail.html',
        controller: 'OrderDetailController'
      })
      .when('/dispatch', {
        templateUrl: 'Scripts/app/templates/dispatch.html',
        controller: 'DispatchBoardController'
      })
      .when('/quote', {
        templateUrl: 'Scripts/app/templates/quote.html',
        controller: 'QuoteController'
      })
      .when('/invoices', {
        templateUrl: 'Scripts/app/templates/invoices.html',
        controller: 'RecentInvoicesController'
      })
      .when('/login', {
        templateUrl: 'Scripts/app/templates/login.html',
        controller: 'LoginController'
      })
      .otherwise({ redirectTo: '/orders' });
  }]);
})();
