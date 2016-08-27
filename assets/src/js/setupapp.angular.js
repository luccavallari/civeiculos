//SETUP APP
var app = angular.module("setupApp",['ngRoute']);
app.config(["$routeProvider","$locationProvider",function($routeProvider, $locationProvider){

  //Roteamento Padrão
  $routeProvider.otherwise({
    controller:   "setupHomeCtrl",
    templateUrl:  "../assets/dist/html/setup/home.html" // ~~> ARQUIVOS DA VIEW
  });


  //Lista
  $routeProvider.when("/database",{
    controller :  "setupDatabaseCtrl",
    templateUrl:  "../assets/dist/html/setup/database.html"
  });

  //Novo
  $routeProvider.when("/create-database",{
    controller :  "setupCreateTablesCtrl",
    templateUrl:  "../assets/dist/html/setup/create_tables.html"
  });

  //Novo
  $routeProvider.when("/configuracoes",{
    controller :  "configuracoesCtrl",
    templateUrl:  "../assets/dist/html/setup/configuracoes.html"
  });

  //Novo
  $routeProvider.when("/finalizar",{
    controller :  "finalizarCtrl",
    templateUrl:  "../assets/dist/html/setup/finalizar.html"
  });

}]); //CONFIG APP


/**/
app.directive("goPage",["$location",function($location){
  return function ( scope, element, attrs ) {
    var path;
    attrs.$observe( 'goPage', function (val) {
      path = val;
    });
    element.bind( 'click', function () {
      scope.$apply( function () {
        $location.path( path );
      });
    });
  };
}]);
/**/

app.controller("setupHomeCtrl",["$scope",function($scope){
  console.log('setupHomeCtrl')
}]);

app.controller("setupDatabaseCtrl",["$scope","$http","$location",function($scope,$http,$location){
  $scope.db_configs = {};
  $scope.loading = false;
  $scope.db_configs_error = false;
  $scope.db_error_message = "";

  $scope.saveDatabaseConfig = function () {
    $scope.loading = true;
    $scope.db_configs_error = false;
    $http.post('setup/configureDataBase',$scope.db_configs).then(function (suc) {
      $location.path("/create-database");
      $scope.loading = false;
    },function (err) {
       $scope.loading = false;
       $scope.db_error_message = err.status+" - "+err.data.message;
       $scope.db_configs_error = true;
    });
  }

}]);

app.controller("setupCreateTablesCtrl",["$scope","$http","$location",function($scope,$http,$location){

  $scope.loading = true;
  $scope.error = false;
  $scope.error_message = "";

  $scope.createTables = function () {
    $scope.loading = true;
    $scope.error = false;
    $http.post('setup/createTablesDataBase').then(function (suc) {
       $location.path('/configuracoes');
    },function (err) {
        $scope.loading = false;
        $scope.error = true;
        $scope.error_message = err.data.header+" - "+err.data.message;
        console.log(err) 
    });  
  }
  $scope.createTables();
}]);

app.controller("configuracoesCtrl",["$scope","$http","$location",function($scope,$http,$location){
  $scope.user_config = {};
  $scope.loading = false;
  $scope.error = false;
  $scope.error_message = "";

  $scope.saveUserConfig = function () {
     $scope.loading = true;
     $scope.error = false;
     $http.post('setup/createUser',$scope.user_config).then(function (suc) {
         $scope.loading = false;
         $location.path("/finalizar");
     },function (err) {
        $scope.loading = false;
        $scope.error = true;
        if(typeof(err.data.message) != 'undefined')
          $scope.error_message = err.status+" - "+err.data.message;
        else
          $scope.error_message = err.status+" - "+err.statusText;
        console.log($scope.error_message)
     })
  }


}]);

app.controller("finalizarCtrl",["$scope",function($scope){
  console.log('finalizarCtrl')
}]);