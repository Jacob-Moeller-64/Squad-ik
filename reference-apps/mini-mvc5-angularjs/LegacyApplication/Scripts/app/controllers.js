(function () {
  'use strict';

  angular.module('shop')
    .controller('ProductListController', ['$scope', '$http', function ($scope, $http) {
      $scope.loading = true;
      $scope.error = null;
      $scope.products = [];
      $http.get('/Products/List').then(function (res) {
        $scope.products = res.data;
        $scope.loading = false;
      }, function () {
        $scope.error = 'Could not load products';
        $scope.loading = false;
      });
    }])

    .controller('ProductDetailController', ['$scope', '$http', '$routeParams', function ($scope, $http, $routeParams) {
      $scope.loading = true;
      $scope.error = null;
      $scope.product = null;
      $http.get('/Products/Detail/' + $routeParams.id).then(function (res) {
        $scope.product = res.data;
        $scope.loading = false;
      }, function () {
        $scope.error = 'Product not found';
        $scope.loading = false;
      });
    }])

    .controller('OrderController', ['$scope', '$http', function ($scope, $http) {
      $scope.lines = [{ productId: 1, quantity: 1, unitPriceCents: 12999 }];
      $scope.promoCode = '';
      $scope.result = null;
      $scope.error = null;

      $scope.addLine = function () {
        $scope.lines.push({ productId: 1, quantity: 1, unitPriceCents: 12999 });
      };

      $scope.submit = function () {
        $scope.error = null;
        $scope.result = null;
        $http.post('/Orders/Create', {
          lines: $scope.lines.map(function (l) {
            return { ProductId: l.productId, Quantity: l.quantity, UnitPriceCents: l.unitPriceCents };
          }),
          promoCode: $scope.promoCode
        }).then(function (res) {
          $scope.result = res.data;
        }, function (res) {
          $scope.error = (res.data && res.data.error) || 'Order failed';
        });
      };
    }]);
})();
