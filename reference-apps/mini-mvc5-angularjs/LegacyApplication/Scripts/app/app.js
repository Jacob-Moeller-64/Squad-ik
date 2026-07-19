(function () {
  'use strict';

  angular.module('shop', ['ngRoute']).config(['$routeProvider', function ($routeProvider) {
    $routeProvider
      .when('/products', {
        templateUrl: 'Scripts/app/templates/product-list.html',
        controller: 'ProductListController'
      })
      .when('/products/:id', {
        templateUrl: 'Scripts/app/templates/product-detail.html',
        controller: 'ProductDetailController'
      })
      .when('/order', {
        templateUrl: 'Scripts/app/templates/order.html',
        controller: 'OrderController'
      })
      .otherwise({ redirectTo: '/products' });
  }]);
})();
