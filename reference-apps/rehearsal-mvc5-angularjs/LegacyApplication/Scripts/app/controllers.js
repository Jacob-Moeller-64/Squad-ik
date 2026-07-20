(function () {
  'use strict';

  // All API payloads are PascalCase (MVC5 JsonResult casing): order.Title,
  // tech.Name, res.data.Error, etc. Do not camelCase these.
  angular.module('fieldserve')

    .controller('OrderListController', ['$scope', '$http', function ($scope, $http) {
      $scope.loading = true;
      $scope.error = null;
      $scope.orders = [];
      $scope.statusFilter = '';
      $scope.statuses = ['Open', 'InProgress', 'Closed'];

      // Inline "new work order" panel (exercises /WorkOrders/Create + SlaCalculator).
      $scope.newOrder = { Title: '', Priority: 'Normal', ContractTier: 'Standard', Weekend: false };
      $scope.priorities = ['Critical', 'High', 'Normal', 'Low'];
      $scope.tiers = ['Standard', 'Gold'];
      $scope.created = null;
      $scope.createError = null;

      function load() {
        $scope.loading = true;
        $scope.error = null;
        var url = $scope.statusFilter
          ? '/WorkOrders/Search?status=' + encodeURIComponent($scope.statusFilter)
          : '/WorkOrders/List';
        $http.get(url).then(function (res) {
          $scope.orders = res.data;
          $scope.loading = false;
        }, function () {
          $scope.error = 'Could not load work orders';
          $scope.loading = false;
        });
      }
      $scope.reload = load;
      load();

      $scope.create = function () {
        $scope.created = null;
        $scope.createError = null;
        $http.post('/WorkOrders/Create', {
          Title: $scope.newOrder.Title,
          Priority: $scope.newOrder.Priority,
          ContractTier: $scope.newOrder.ContractTier,
          Weekend: $scope.newOrder.Weekend
        }).then(function (res) {
          $scope.created = res.data; // { WorkOrderId, Title, Priority, DueInHours }
        }, function (res) {
          $scope.createError = (res.data && res.data.Error) || 'Create failed';
        });
      };
    }])

    .controller('OrderDetailController', ['$scope', '$http', '$routeParams', function ($scope, $http, $routeParams) {
      $scope.loading = true;
      $scope.error = null;
      $scope.order = null;
      $http.get('/WorkOrders/Detail/' + encodeURIComponent($routeParams.id)).then(function (res) {
        $scope.order = res.data;
        $scope.loading = false;
      }, function () {
        $scope.error = 'Work order not found';
        $scope.loading = false;
      });
    }])

    .controller('DispatchBoardController', ['$scope', '$http', function ($scope, $http) {
      $scope.orders = [];
      $scope.technicians = [];
      $scope.form = { workOrderId: '', technicianId: '' };
      $scope.result = null;
      $scope.error = null;

      $http.get('/WorkOrders/List').then(function (res) { $scope.orders = res.data; });
      $http.get('/Technicians/List').then(function (res) { $scope.technicians = res.data; });

      $scope.assign = function () {
        $scope.result = null;
        $scope.error = null;
        $http.post('/Dispatch/Assign', {
          WorkOrderId: $scope.form.workOrderId,
          TechnicianId: parseInt($scope.form.technicianId, 10)
        }).then(function (res) {
          $scope.result = res.data; // { TechnicianId, WorkOrderId, ActiveLoad }
        }, function (res) {
          $scope.error = (res.data && res.data.Error) || 'Assignment failed';
        });
      };
    }])

    .controller('QuoteController', ['$scope', '$http', function ($scope, $http) {
      $scope.laborHours = 2;
      $scope.hourlyRateCents = 9500;
      $scope.parts = [{ cents: 0 }];
      $scope.visits = 1;
      $scope.result = null;
      $scope.error = null;

      $scope.addPart = function () { $scope.parts.push({ cents: 0 }); };
      $scope.removePart = function (index) { $scope.parts.splice(index, 1); };

      $scope.submit = function () {
        $scope.result = null;
        $scope.error = null;
        $http.post('/Invoices/Quote', {
          LaborHours: $scope.laborHours,
          HourlyRateCents: $scope.hourlyRateCents,
          PartsCents: $scope.parts.map(function (p) { return parseInt(p.cents, 10) || 0; }),
          Visits: $scope.visits
        }).then(function (res) {
          $scope.result = res.data; // { LaborCents, PartsCents, TravelCents, TaxCents, TotalCents }
        }, function (res) {
          $scope.error = (res.data && res.data.Error) || 'Quote failed';
        });
      };
    }])

    .controller('RecentInvoicesController', ['$scope', '$http', '$location', function ($scope, $http, $location) {
      $scope.loading = true;
      $scope.invoices = [];
      $http.get('/Invoices/Recent').then(function (res) {
        // Forms auth quirk: an unauthenticated request 302s to the login page and
        // XHR follows it, so "success" may actually be the login HTML. Anything
        // that is not the invoice array means we are not signed in.
        if (angular.isArray(res.data)) {
          $scope.invoices = res.data;
          $scope.loading = false;
        } else {
          $location.path('/login');
        }
      }, function () {
        $location.path('/login'); // real 401/redirect failure
      });
    }])

    .controller('LoginController', ['$scope', '$http', '$location', function ($scope, $http, $location) {
      $scope.username = '';
      $scope.password = '';
      $scope.error = null;

      $scope.login = function () {
        $scope.error = null;
        $http.post('/Account/Login', {
          Username: $scope.username,
          Password: $scope.password
        }).then(function () {
          $location.path('/invoices');
        }, function (res) {
          $scope.error = (res.data && res.data.Error) || 'Login failed';
        });
      };
    }]);
})();
