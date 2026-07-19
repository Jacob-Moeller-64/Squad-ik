(function () {
  'use strict';

  // Legacy element directive with link-fn DOM manipulation: the classification hotspot
  // the angularjs adapter warns about (likely no-counterpart -> wrap per D-003).
  angular.module('shop')
    .directive('productCard', function () {
      return {
        restrict: 'E',
        scope: { product: '=' },
        template:
          '<div class="product-card" ng-class="{oos: !product.InStock}">' +
          '  <h3>{{product.Name}}</h3>' +
          '  <p class="cat">{{product.Category}}</p>' +
          '  <p class="price">{{product.UnitPriceCents / 100 | currency}}</p>' +
          '  <p class="stock">{{product.InStock ? "In stock" : "Out of stock"}}</p>' +
          '  <a ng-href="#!/products/{{product.Id}}">Details</a>' +
          '</div>',
        link: function (scope, element) {
          element.on('mouseenter', function () { element.addClass('hover'); });
          element.on('mouseleave', function () { element.removeClass('hover'); });
        }
      };
    })

    // Modern-ish .component(): the easy swap case.
    .component('orderSummary', {
      bindings: { result: '<' },
      template:
        '<div class="order-summary" ng-if="$ctrl.result">' +
        '  <h3>Order {{$ctrl.result.orderId}}</h3>' +
        '  <dl>' +
        '    <dt>Subtotal</dt><dd>{{$ctrl.result.subtotalCents / 100 | currency}}</dd>' +
        '    <dt>Discount</dt><dd>{{$ctrl.result.discountPercent}}% (-{{$ctrl.result.discountCents / 100 | currency}})</dd>' +
        '    <dt>Total</dt><dd class="total">{{$ctrl.result.totalCents / 100 | currency}}</dd>' +
        '  </dl>' +
        '</div>'
    });
})();
