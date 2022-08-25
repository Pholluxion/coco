(function () {
    'use strict';

    angular
            .module('app')
            .controller('CarController', CarController);

    CarController.$inject = ['UserService', '$rootScope', 'FlashService', '$location', '$route'];
    function CarController(UserService, $rootScope, FlashService, $location, $route) {
        var vm = this;

        vm.user = null;
        vm.carList = null;

        initController();

        vm.gotoHome = gotoHome;
        vm.gotoCar = gotoCar;
        vm.gotoPerfil = gotoPerfil;


        function gotoPerfil() {
            $location.path('/profile');
        }

        function gotoHome() {
            $location.path('/');
        }

        function gotoCar() {
            $location.path('/car');
        }

        function initController() {
            loadCurrentUser();

        }

        function loadCurrentUser() {
            vm.user = $rootScope.globals.currentUser;
            console.log(vm.user);
        }
        
        





    }

})();