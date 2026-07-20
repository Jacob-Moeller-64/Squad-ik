(function () {
  'use strict';

  // moneyCents: integer cents -> "$1,234.56". All API money fields are integer
  // cents (PascalCase, e.g. TotalCents); nothing in the app uses floats.
  angular.module('fieldserve')
    .filter('moneyCents', function () {
      return function (cents) {
        if (cents === null || cents === undefined || isNaN(cents)) return '';
        var negative = cents < 0;
        var abs = Math.abs(Math.floor(cents));
        var dollars = String(Math.floor(abs / 100)).replace(/\B(?=(\d{3})+(?!\d))/g, ',');
        var rem = ('0' + (abs % 100)).slice(-2);
        return (negative ? '-$' : '$') + dollars + '.' + rem;
      };
    });
})();
