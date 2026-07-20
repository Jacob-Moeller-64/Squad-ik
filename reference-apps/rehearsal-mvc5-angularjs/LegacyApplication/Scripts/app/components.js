(function () {
  'use strict';

  angular.module('fieldserve')

    // Legacy element directive with '@' string bindings and link-fn DOM fiddling —
    // the classic "no direct counterpart" migration hotspot.
    // Usage: <order-card order-id="{{o.Id}}" title="{{o.Title}}" status="{{o.Status}}"
    //                    priority="{{o.Priority}}" site="{{o.Site}}"></order-card>
    .directive('orderCard', function () {
      return {
        restrict: 'E',
        scope: {
          id: '@orderId',
          title: '@',
          status: '@',
          priority: '@',
          site: '@'
        },
        template:
          '<div class="order-card">' +
          '  <h3>{{title}}</h3>' +
          '  <p class="meta">{{id}} &middot; {{site}}</p>' +
          '  <p class="meta prio">Priority: {{priority}}</p>' +
          '  <status-badge status="{{status}}"></status-badge>' +
          '  <p><a ng-href="#!/orders/{{id}}">Open record</a></p>' +
          '</div>',
        link: function (scope, element) {
          // jQuery-era hover effect, kept for period accuracy.
          element.on('mouseenter', function () { element.children().addClass('hover'); });
          element.on('mouseleave', function () { element.children().removeClass('hover'); });
        }
      };
    })

    // Tiny presentational directive: status -> colored badge class.
    .directive('statusBadge', function () {
      return {
        restrict: 'E',
        scope: { status: '@' },
        template:
          '<span class="badge" ng-class="{' +
          "'badge-open': status === 'Open'," +
          "'badge-inprogress': status === 'InProgress'," +
          "'badge-closed': status === 'Closed'" +
          '}">{{status}}</span>'
      };
    })

    // Modern-ish .component() with one-way binding: the easy swap case.
    // result is the PascalCase /Invoices/Quote payload.
    .component('quoteSummary', {
      bindings: { result: '<' },
      template:
        '<div class="quote-summary" ng-if="$ctrl.result">' +
        '  <div class="panel-title">Quote breakdown</div>' +
        '  <table>' +
        '    <tr><td>Labor</td><td class="amt">{{$ctrl.result.LaborCents | moneyCents}}</td></tr>' +
        '    <tr><td>Parts</td><td class="amt">{{$ctrl.result.PartsCents | moneyCents}}</td></tr>' +
        '    <tr><td>Travel</td><td class="amt">{{$ctrl.result.TravelCents | moneyCents}}</td></tr>' +
        '    <tr><td>Tax (8%, travel exempt)</td><td class="amt">{{$ctrl.result.TaxCents | moneyCents}}</td></tr>' +
        '    <tr class="total"><td>Total</td><td class="amt">{{$ctrl.result.TotalCents | moneyCents}}</td></tr>' +
        '  </table>' +
        '</div>'
    });
})();
