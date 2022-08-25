(function () {
    'use strict';

    angular
            .module('app')
            .controller('HomeController', HomeController);

    HomeController.$inject = ['UserService', '$rootScope', 'FlashService', '$location', '$cookies', '$timeout', '$scope', '$route'];
    function HomeController(UserService, $rootScope, FlashService, $location, $cookies, $timeout, $scope, $route) {
        var vm = this;

        vm.user = null;
        vm.selectPro = null;
        vm.carList = [];

        vm.deleteUser = deleteUser;
        vm.showModal = showModal;
        vm.gotoPerfil = gotoPerfil;
        vm.gotoCart = gotoCart;
        vm.gotoHome = gotoHome;
        vm.addToCart = addToCart;
        vm.selectProduct = selectProduct;
        vm.loadAllProductsFilter = loadAllProductsFilter;



        initController();

        function initController() {
            loadCurrentUser();
            loadAllUsers();
            loadAllProducts();
            loadAllUserProducts();
            loadAllCategories();
            loadCart();

        }
        function gotoHome() {
            $location.path('/');
        }
        function gotoCart() {
            $location.path('/cart');
        }
        function gotoPerfil() {
            $location.path('/profile');
        }

        function loadCart() {
            if (vm.carList.length === 0) {
                vm.carListIsEmty = false;
            } else {
                vm.carListIsEmty = true;
            }
        }

        function addToCart() {
            console.log(vm.carList);
            vm.carList = $rootScope.cart.cartProducts;
            vm.carList.push( vm.selectPro);

            $rootScope.cart = {
                cartProducts: vm.carList
            };


            vm.carList = $rootScope.cart.cartProducts;
            console.log(vm.carList);
             //FlashService.Success('Nuevo producto agregado al carrito', true);

        }
        function selectProduct(product) {
            vm.selectPro = product;

        }


        function loadCurrentUser() {
            vm.user = $rootScope.globals.currentUser;
            console.log(vm.user);
        }

        function loadAllUsers() {
            UserService.GetAll()
                    .then(function (users) {
                        vm.allUsers = users.listUsers;

                    });
        }

        function loadAllProducts() {
            UserService.GetAllProducts()
                    .then(function (product) {
                        vm.allProducts = product.listProduct;
                        if (product.listProduct.length === 0) {
                            vm.valProducts = false;
                        } else {
                            vm.valProducts = true;
                        }
                        console.log(product);
                    });
        }

        function loadAllProductsFilter(cat) {

            UserService.GetProductByCatId(cat)
                    .then(function (product) {
                        if (cat !== null && cat !== undefined) {

                            console.log(cat);
                            vm.valProductsFilter = true;
                            vm.allProductsFilter = product.listProduct;
                            //console.log(vm.allProductsFilter);
                            if (product.listProduct.length === 0) {
                                vm.valProductsNull = false;
                            } else {
                                vm.valProductsNull = true;

                            }
                        } else {
                            vm.valProductsFilter = false;

                            $route.reload();
                        }
                    });
        }

        function loadAllCategories() {
            UserService.GetAllCategories()
                    .then(function (category) {
                        vm.allCategories = category.listCategory;

                    });
        }

        function loadAllUserProducts() {
            UserService.GetAllUserProducts()
                    .then(function (product) {
                        vm.allUserProducts = product.listProductUser;

                    });
        }

        function deleteUser(id) {
            UserService.Delete(id)
                    .then(function () {
                        loadAllUsers();
                    });
        }


        function showModal(p) {
            vm.idSeller = null;
            vm.selectProductName = p.name;
            vm.selectProductImg = p.imageUrl;
            vm.selectProductDes = p.description;
            vm.selectProductPrice = p.price;

            UserService.GetById(p.id)
                    .then(function (user) {
                        vm.seller = user.user;
                        console.log(vm.seller);
                    });



        }

    }

})();