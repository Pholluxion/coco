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
        vm.showModal = showModal;
        vm.total = 0;


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
            loadTotal();
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

        function loadTotal() {
            vm.carList = $rootScope.cart.cartProducts;

            for (var i = 0; i < vm.carList.length; i++) {
                vm.total = vm.total + (vm.carList[i].price.replace(/\./g, "") - 0);
            }
            console.log(vm.total);
        }

        function showModal(p) {
            vm.idSeller = null;
            vm.selectProductId = p.id;
            vm.selectProductName = p.name;
            vm.selectProductImg = p.imageUrl;
            vm.selectProductDes = p.description;
            vm.selectProductPrice = p.price;

            vm.selectProductId = p.id;
            vm.updateProductImg = p.imageUrl;
            vm.updateProductName = p.name;
            vm.updateProductPrice = p.price;
            vm.updateProductDescription = p.description;

            console.log(p);
            UserService.GetById(p.id)
                    .then(function (user) {
                        vm.seller = user.user;
                        console.log(vm.seller);
                    });



        }









    }

})();