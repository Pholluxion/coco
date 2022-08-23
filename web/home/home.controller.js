(function () {
    'use strict';

    angular
            .module('app')
            .controller('HomeController', HomeController);

    HomeController.$inject = ['UserService', '$rootScope', 'FlashService', '$location'];
    function HomeController(UserService, $rootScope, FlashService, $location) {
        var vm = this;

        vm.user = null;
        vm.deleteUser = deleteUser;
        vm.showModal = showModal;
        vm.gotoPerfil = gotoPerfil;


        initController();

        function gotoPerfil() {
            $location.path('/profile');
        }

        function gotoHome() {
            $location.path('/');
        }

        function initController() {
            loadCurrentUser();
            loadAllUsers();
            loadAllProducts();
            loadAllUserProducts();
            loadAllCategories();

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