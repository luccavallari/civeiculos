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
  $routeProvider.when("/novo",{
    controller :  "novoSiteCtrl",
    templateUrl:  "../assets/html/novo_site.html"
  });

  //Novo
  $routeProvider.when("/editar/:id_site",{
    controller :  "editarSiteCtrl",
    templateUrl:  "../assets/html/editar_site.html"
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

app.controller("setupDatabaseCtrl",["$scope",function($scope){
  console.log('setupDatabaseCtrl')
}]);