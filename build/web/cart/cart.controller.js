(function () {
    'use strict';

    angular
            .module('app')
            .controller('CartController', CartController);

    CartController.$inject = ['UserService', '$rootScope', 'FlashService', '$location', '$route'];
    function CartController(UserService, $rootScope, FlashService, $location, $route) {
        var vm = this;

        vm.user = null;
        vm.carListIsEmty = null;


        initController();

        vm.gotoHome = gotoHome;
        vm.gotoCart = gotoCart;
        vm.gotoPerfil = gotoPerfil;


        function gotoPerfil() {
            $location.path('/profile');
        }

        function gotoHome() {
            $location.path('/');
        }

        function gotoCart() {
            $location.path('/cart');
        }

        function initController() {
            loadCurrentUser();
            try {
                loadCart();
            } catch (e) {
                console.log(e);
            }


        }

        function loadCurrentUser() {
            vm.user = $rootScope.globals.currentUser;
            console.log(vm.user);
        }
        function loadCart() {
            vm.carList = $rootScope.cart.cartProducts;
            console.log(vm.carList);

            if (vm.carList.length === 0) {
                vm.carListIsEmty = false;
            } else {
                vm.carListIsEmty = true;
            }

        }










    }

})();